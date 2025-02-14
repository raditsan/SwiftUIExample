//
//  CheckboxView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 14/02/25.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isChecked ? .blue : .gray)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
