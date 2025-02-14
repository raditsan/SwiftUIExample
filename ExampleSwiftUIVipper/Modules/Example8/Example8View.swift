//
//  Example8View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 13/02/25.
//

import SwiftUI

struct Example8View: View {
    @State private var selectedValue: SelectOptionView.Items? = nil
    var body: some View {
        VStack {
            SelectOptionView()
                .setDatasource([
                    .init(name: "Option 1"),
                    .init(name: "Option 2"),
                    .init(name: "Option 3"),
                    .init(name: "Option 4"),
                    .init(name: "Option 5"),
                    .init(name: "Option 6"),
                ])
                .onValueChange { prevValue, newValue in
                    print("onValueChange prev=\(prevValue?.name ?? ""), new=\(newValue?.name ?? "")")
                    selectedValue = newValue
                }
            Text("Hello \(selectedValue?.name ?? "")")
            Spacer()
        }
        .padding()
    }
}

