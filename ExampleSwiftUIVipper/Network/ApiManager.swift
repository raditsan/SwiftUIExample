//
//  ApiManager.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 17/02/25.
//


import Foundation
import Moya

protocol ApiManagerProtocol {
    func fetchUsers(completion: @escaping (Result<[Example11UserModel], Error>) -> Void)
    func createUser(name: String, email: String, completion: @escaping (Result<Example11UserModel, Error>) -> Void)
    func updateUser(id: Int, name: String, email: String, completion: @escaping (Result<Example11UserModel, Error>) -> Void)
    func patchUser(id: Int, name: String?, completion: @escaping (Result<Example11UserModel, Error>) -> Void)
    func deleteUser(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

class ApiManager: ApiManagerProtocol {
    static let shared = ApiManager()
    
    private let provider = MoyaProvider<ApiService>()

    func fetchUsers(completion: @escaping (Result<[Example11UserModel], Error>) -> Void) {
        provider.request(.getUsers) { result in
            switch result {
            case .success(let response):
                do {
                    let users = try JSONDecoder().decode([Example11UserModel].self, from: response.data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func createUser(name: String, email: String, completion: @escaping (Result<Example11UserModel, Error>) -> Void) {
        provider.request(.createUser(name: name, email: email)) { result in
            switch result {
            case .success(let response):
                do {
                    let user = try JSONDecoder().decode(Example11UserModel.self, from: response.data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateUser(id: Int, name: String, email: String, completion: @escaping (Result<Example11UserModel, Error>) -> Void) {
        provider.request(.updateUser(id: id, name: name, email: email)) { result in
            switch result {
            case .success(let response):
                do {
                    let user = try JSONDecoder().decode(Example11UserModel.self, from: response.data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func patchUser(id: Int, name: String?, completion: @escaping (Result<Example11UserModel, Error>) -> Void) {
        provider.request(.patchUser(id: id, name: name)) { result in
            switch result {
            case .success(let response):
                do {
                    let user = try JSONDecoder().decode(Example11UserModel.self, from: response.data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteUser(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.deleteUser(id: id)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
