//
//  Spacing.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 20/02/25.
//


import SwiftUI

struct Spacing {
    // Common Spacing Values
    static let extraSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let extraLarge: CGFloat = 32
    
    // Padding Helpers
    static let paddingSmall = EdgeInsets(top: small, leading: small, bottom: small, trailing: small)
    static let paddingMedium = EdgeInsets(top: medium, leading: medium, bottom: medium, trailing: medium)
    static let paddingLarge = EdgeInsets(top: large, leading: large, bottom: large, trailing: large)
}