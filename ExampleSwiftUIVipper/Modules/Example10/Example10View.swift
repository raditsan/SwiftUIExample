//
//  Example10View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 14/02/25.
//

import SwiftUI


struct Example10View: View {
    @State private var text: String = ""

    var body: some View {
        VStack {
            NumberTextFieldView(text: $text)
                .onValueChanged({ value in
                    print("value changed: \(value)")
                })
            Text("Result: \(text)")
        
        }
        .padding()
    }
}

#Preview {
    Example10View()
}
