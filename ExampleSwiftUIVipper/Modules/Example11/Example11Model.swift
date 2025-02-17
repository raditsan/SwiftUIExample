//
//  Example11Model.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 17/02/25.
//

import Foundation

struct Example11UserModel: Identifiable, Codable {
    let id: Int
    var name: String
    var email: String
    var isDeleting: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case email
//        case isDeleting
    }
}
