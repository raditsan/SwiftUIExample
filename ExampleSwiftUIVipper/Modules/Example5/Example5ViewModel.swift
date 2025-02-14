//
//  Example5ViewModel.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 12/02/25.
//

import SwiftUI

class Example5ViewModel: ObservableObject {
    @Published var users =  [Example5Model]()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        self.users = [
            Example5Model(name: "John Doe", age: 25),
            Example5Model(name: "Jane Smith", age: 30),
            Example5Model(name: "Alice Johnson", age: 28)
        ]
    }
}
