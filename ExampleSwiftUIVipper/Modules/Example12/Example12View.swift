//
//  Example12View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 17/02/25.
//

import SwiftUI

struct Example12View: View {
    @State private var selectedIndex = 0
    @State private var gridsView: [AnyView] = [
        AnyView(GridSimpleView()),
        AnyView(GridSectionView()),
        AnyView(HorizontalGridView()),
    ]
    
    var body: some View {
        ScrollView {
            gridsView[selectedIndex]
        }
        .navigationTitle("Grid Example")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    selectedIndex = (selectedIndex + 1) % gridsView.count
                }) {
                    Text("Switch Grid")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        Example12View()
    }
}

struct GridSimpleView: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(0..<20) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: 100)
                    .overlay(
                        Text("Item \(index + 1)")
                            .foregroundColor(.white)
                            .font(.headline)
                    )
            }
        }
        .padding(16)
    }
}

struct GridSectionView: View {
    let sections: [GridSection] = [
        GridSection(title: "Fruits", items: ["🍎", "🍌", "🍇", "🍉", "🍓", "🍍"]),
        GridSection(title: "Vegetables", items: ["🥕", "🥦", "🌽", "🥬", "🍆", "🫑"]),
        GridSection(title: "Desserts", items: ["🍩", "🍪", "🍰", "🍫", "🧁", "🥧"])
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(sections, id: \.title) { section in
                VStack(alignment: .leading) {
                    Text(section.title)
                        .font(.headline)
                        .padding(.leading)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(section.items, id: \.self) { item in
                            Text(item)
                                .frame(width: 80, height: 80)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2)
                                .font(.largeTitle)
                        }
                    }
                }
            }
        }
    }
}

struct GridSection {
    let title: String
    let items: [String]
}


struct HorizontalGridView: View {
    @State private var items = Array(1...10) // Initial items
    
    let rows = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        Button(action: {
            // Add a new item
            items.append(items.count + 1)
        }) {
            Text("Add Item")
        }
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text("\(item)")
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 3)
                }
            }
            .padding()
        }
    }
}
