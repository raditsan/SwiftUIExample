//
//  Typography.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 20/02/25.
//

import SwiftUI

struct Typography {
    // Font Sizes
    static let h1: Font = .system(size: 32, weight: .bold, design: .default)
    static let h2: Font = .system(size: 28, weight: .semibold, design: .default)
    static let h3: Font = .system(size: 24, weight: .medium, design: .default)
    static let body: Font = .system(size: 16, weight: .regular, design: .default)
    static let caption: Font = .system(size: 12, weight: .light, design: .default)
    
    // Custom Font Styles
    static func customFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .default)
    }
}
