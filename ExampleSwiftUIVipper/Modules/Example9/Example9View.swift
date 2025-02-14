//
//  Example9View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 13/02/25.
//

import SwiftUI

struct Example9View: View {
    @State private var items: [CheckboxGroupView.Items] = [
        .init(name: "Option 1", isChecked: false),
        .init(name: "Option 2", isChecked: false),
        .init(name: "Option 3 akndkas d ask dksa das dkas das dkasd asl dljas djlas dl askd jaks dkas dkas djlas dljsa", isChecked: false),
        .init(name: "Option 4", isChecked: false)
    ]

    var body: some View {
        VStack {
            CheckboxGroupView(items: $items)
            Text("Selected Options: \(selectedOptions)")
            Spacer()
        }
    }

    // Computed property to get selected options
    var selectedOptions: String {
        items.filter { $0.isChecked }.map { $0.name }.joined(separator: ", ")
    }
}
