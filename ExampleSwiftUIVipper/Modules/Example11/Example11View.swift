//
//  Example11View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 17/02/25.
//

import SwiftUI

struct Example11View: View {
    @StateObject private var viewModel = Example11ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(viewModel.users, id: \.id) { user in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(user.id) - \(user.name)").bold()
                            Text(user.email).foregroundColor(.gray)
                        }.onTapGesture {
                            viewModel.showAddUserModal.toggle()
                            viewModel.selectedUser = user
                        }
                        Spacer()
                        if user.isDeleting {
                            ProgressView()
                        } else {
                            Button("❌") {
                                viewModel.deleteUser(id: user.id)
                                print("Delete Click")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        
                    }
                }
            }
        }
        .onAppear { viewModel.fetchUsers() }
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showAddUserModal.toggle()
                    }) {
                        Text("Add User")
                    }
                    .disabled(viewModel.isAddingOrEditingUser)
                }
            }
            .onAppear { viewModel.fetchUsers() }
            .sheet(isPresented: $viewModel.showAddUserModal) {
                AddUserView(viewModel: viewModel, isPresented: $viewModel.showAddUserModal)
            }
        
    }
}

struct AddUserView: View {
    @ObservedObject var viewModel: Example11ViewModel
    @Binding var isPresented: Bool

    var name: Binding<String> {
        return Binding(
            get: { viewModel.selectedUser.name },
            set: { viewModel.selectedUser.name = $0 }
        )
    }
    
    var email: Binding<String> {
        return Binding(
            get: { viewModel.selectedUser.email },
            set: { viewModel.selectedUser.email = $0 }
        )
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Name", text: name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Email", text: email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                }
            }
            .navigationTitle("Add User")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if !name.wrappedValue.isEmpty, !email.wrappedValue.isEmpty {
                            viewModel.createUser()
                            isPresented = false
                        }
                    }
                    .disabled(name.wrappedValue.isEmpty || email.wrappedValue.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        Example11View()
            .navigationTitle(Text("Example 11"))
    }
}
