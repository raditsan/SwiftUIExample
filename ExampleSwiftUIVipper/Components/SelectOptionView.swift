//
//  SelectOptionView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 13/02/25.
//

import SwiftUI

struct SelectOptionView: View {
    class Items: Identifiable {
        let id: String
        let name: String
        
        init(id: String = UUID().uuidString, name: String) {
            self.id = id
            self.name = name
        }
    }
    
    
    @State private var searchText = ""
    @State private var isDropdownVisible = false
    @State var selectedItem: Items? {
        didSet {
            let oldValue = oldValue
            let newValue = selectedItem
            onValueChange?(oldValue, newValue)
        }
    }
    
    private var onValueChange: ((Items?, Items?) -> Void)? = nil
    private var dataSource: [Items] = []
    
    // Filtered list based on search text
    var filteredItems: [Items] {
        if searchText.isEmpty {
            return dataSource
        } else {
            return dataSource.filter { $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init() { }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Parent View
            Button(action: {
                // Toggle dropdown visibility
                isDropdownVisible.toggle()
            }) {
                HStack {
                    Text(selectedItem?.name ?? "Select an item")
                        .foregroundColor(selectedItem == nil ? .gray : .black)
                    Spacer()
                    Image(systemName: isDropdownVisible ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Child View (Dropdown)
            if isDropdownVisible {
                VStack {
                    // Search bar
                    TextField("Search", text: $searchText)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    Divider()
                        .padding(.horizontal, 20)
                    // List of items
                    List(filteredItems) { item in
                        Button(action: {
                            selectedItem = item
                            isDropdownVisible = false
                        }) {
                            Text(item.name)
                                .foregroundColor(.black)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: 200)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isDropdownVisible)
    }
}

extension SelectOptionView {
    func onValueChange(_ handler: @escaping (Items?, Items?) -> Void) -> Self {
        var copy = self
        copy.onValueChange = handler
        return copy
    }
    
    func setDatasource(_ dataSource: [Items]) -> Self {
        var copy = self
        copy.dataSource = dataSource
        return copy
    }
}
