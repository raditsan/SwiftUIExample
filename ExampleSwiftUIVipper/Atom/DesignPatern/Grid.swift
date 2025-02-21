//
//  Grid.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 20/02/25.
//


import SwiftUI

struct Grid {
    // Screen Breakpoints
    static let smallDeviceWidth: CGFloat = 375
    static let mediumDeviceWidth: CGFloat = 768
    static let largeDeviceWidth: CGFloat = 1024
    
    // Column Widths
    static let columnWidth: CGFloat = 80
    static let gutterWidth: CGFloat = 16
    
    // Responsive Layout Helpers
    static func isSmallDevice(_ geometry: GeometryProxy) -> Bool {
        return geometry.size.width < mediumDeviceWidth
    }
    
    static func isMediumDevice(_ geometry: GeometryProxy) -> Bool {
        return geometry.size.width >= mediumDeviceWidth && geometry.size.width < largeDeviceWidth
    }
    
    static func isLargeDevice(_ geometry: GeometryProxy) -> Bool {
        return geometry.size.width >= largeDeviceWidth
    }
}