//
//  ApiService.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 17/02/25.
//


import Foundation
import Moya

enum ApiService {
    case getUsers
    case createUser(name: String, email: String)
    case updateUser(id: Int, name: String, email: String)
    case patchUser(id: Int, name: String?)
    case deleteUser(id: Int)
}

extension ApiService: TargetType {
    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .createUser:
            return "/users"
        case .updateUser(let id, _, _), .patchUser(let id, _), .deleteUser(let id):
            return "/users/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUsers: return .get
        case .createUser: return .post
        case .updateUser: return .put
        case .patchUser: return .patch
        case .deleteUser: return .delete
        }
    }

    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .createUser(let name, let email):
            let params = ["name": name, "email": email]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateUser(_, let name, let email):
            let params = ["name": name, "email": email]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .patchUser(_, let name):
            var params: [String: Any] = [:]
            if let name = name { params["name"] = name }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .deleteUser:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
