//
//  HomeEntity.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

struct HomeItemEntity: Identifiable {
    let id = UUID()
    let name: String
    let destination: AnyView 
}
