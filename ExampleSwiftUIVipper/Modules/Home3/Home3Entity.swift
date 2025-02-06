// 
//  Home3Entity.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import SwiftUI

class Home3Entity: ObservableObject {
    @Published var items: [[String: String]] = []
    @Published var isFetchData: Bool = false
}
