//
//  CheckboxGroupView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 14/02/25.
//

import SwiftUI

struct CheckboxGroupView: View {
    struct Items: Identifiable {
        let id: String
        let name: String
        var isChecked: Bool
        
        init(id: String = UUID().uuidString, name: String, isChecked: Bool = false) {
            self.id = id
            self.name = name
            self.isChecked = isChecked
        }
    }
    
    @Binding var items: [Items]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach($items) { $item in
                HStack {
                    CheckboxView(isChecked: $item.isChecked)
                    Text(item.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    item.isChecked.toggle()
                }
            }
        }
        
    }
}
