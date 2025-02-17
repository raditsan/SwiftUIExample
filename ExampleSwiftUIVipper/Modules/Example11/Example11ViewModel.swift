//
//  Example11ViewModel.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 17/02/25.
//
import Foundation

class Example11ViewModel: ObservableObject {
    @Published var users: [Example11UserModel] = []
    @Published var isLoading = false
    @Published var isAddingOrEditingUser = false
    @Published var showAddUserModal = false  {
        didSet {
            if showAddUserModal {
                resetSelectedUser()
            }
        }
    }
    @Published var errorMessage: String?
    @Published var selectedUser = Example11UserModel(id: 0, name: "", email: "")
    
    private let apiManager: ApiManagerProtocol
    
    init(apiManager: ApiManagerProtocol = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    private func resetSelectedUser() {
        self.selectedUser = Example11UserModel(id: 0, name: "", email: "")
    }

    func fetchUsers() {
        isLoading = true
        apiManager.fetchUsers { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    func createUser(name: String, email: String) {
        isAddingOrEditingUser = true
        apiManager.createUser(name: name, email: email) { [weak self] result in
            switch result {
            case .success(let user):
                self?.isAddingOrEditingUser = false
                self?.users.append(user)
            case .failure(let error):
                print("Failed to create user: \(error.localizedDescription)")
            }
        }
    }
    
    func createUser() {
        if selectedUser.id == 0 {
            createUser(name: selectedUser.name, email: selectedUser.email)
        } else if selectedUser.id > 0 {
            updateUser(id: selectedUser.id)
        }
    }

    func deleteUser(id: Int) {
        if let userIdx = users.firstIndex(where: { $0.id == id }) {
            users[userIdx].isDeleting = true
        }
        apiManager.deleteUser(id: id) { [weak self] result in
            switch result {
            case .success:
                self?.users.removeAll { $0.id == id }
            case .failure(let error):
                self?.errorMessage = "Failed to delete user: \(error.localizedDescription)"
            }
        }
    }
    
    func updateUser(id: Int) {
        isAddingOrEditingUser = true
        apiManager.updateUser(id: id, name: selectedUser.name, email: selectedUser.email) { [weak self] result in
            switch result {
            case .success:
                if let userIdx = self?.users.firstIndex(where: { $0.id == id }), let selectedUser = self?.selectedUser {
                    self?.isAddingOrEditingUser = false
                    self?.users[userIdx] = selectedUser
                }
            case .failure(let error):
                self?.errorMessage = "Failed to update user: \(error.localizedDescription)"
            }
        }
    }
}
