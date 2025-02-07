// 
//  Home2Entity.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI
import Combine

class Home2Entity: ObservableObject {
    @Published var items: [[String: String]] = []
    @Published var isFetchData: Bool = false
}
