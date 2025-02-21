//
//  Example15View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 20/02/25.
//

import SwiftUI

struct Example15View: View {
    var body: some View {
        let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9"]
            
        ScrollView {
            ResponsiveGridView(items: items) { item in
                VStack {
                    Text(item)
                        .foregroundStyle(Color.primary)
                        .padding(Spacing.small)
                        .font(Typography.body)
                }
            }
        }
        .background(Color.backgroundColor)
    }
}

#Preview {
    Example15View()
}

struct ResponsiveGridView<Content: View>: View {
    let items: [String]
    let content: (String) -> Content
    
    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = Grid.isSmallDevice(geometry)
            let isMediumDevice = Grid.isMediumDevice(geometry)
            
            LazyVGrid(columns: gridLayout(for: geometry), spacing: Spacing.medium) {
                ForEach(items, id: \.self) { item in
                    content(item)
                        .frame(height: 100) // Fixed height for simplicity
                        .background(Color.primaryColor)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
            }
            .padding(Spacing.large)
        }
    }
    
    // Dynamically determine the number of columns based on device size
    private func gridLayout(for geometry: GeometryProxy) -> [GridItem] {
        if Grid.isSmallDevice(geometry) {
            print("Small Device")
            return [GridItem(.flexible())] // 1 column for small devices
        } else if Grid.isMediumDevice(geometry) {
            print("Medium Device")
            return Array(repeating: GridItem(.flexible(), spacing: Spacing.medium), count: 2) // 2 columns for medium devices
        } else {
            print("Large Device")
            return Array(repeating: GridItem(.flexible(), spacing: Spacing.medium), count: 3) // 3 columns for large devices
        }
    }
}
