//
//  Example10View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 14/02/25.
//

import SwiftUI

struct Example10View: View {
    @State private var numberText: String = ""
    @State private var score = 0
    
    @State private var myDouble: Double = 0.673
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    @State private var text: String = ""
    @State private var cursorPosition: Int = 0

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @State var number: Int = 0

    let numberFormatter2 = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.generatesDecimalNumbers = true
            numberFormatter.maximumFractionDigits = 0
            numberFormatter.groupingSize = 3
            return numberFormatter
        }()

    

    var body: some View {
        VStack {
//            NumberTextFieldView()
//            NumberTextFieldView(value: $numberText, placeholder: "Enter a number")
//                .padding()
//                .frame(height: 40)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
            
            Text("You entered: \(numberText)")
                .padding()
            
            TextField("Enter your score", value: $score, formatter: formatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Your score was \(score)")
            
            TextField(
                value: $myDouble,
                formatter: numberFormatter
            ) {
                Text("Double")
            }
            Text(myDouble, format: .number)
            Text(myDouble, format: .number.precision(.significantDigits(5)))
            Text(myDouble, format: .number.notation(.scientific))
            
            TextField("1000", value: $number, formatter: numberFormatter2)
                .keyboardType(.numberPad)
            NumberTextFieldView(text: $text)
                .onValueChanged({ value in
                    print("value changed: \(value)")
                })
                .frame(height: 40)
                .padding()
                .border(Color.gray, width: 1)
            Text("Result: \(text)")
        }
        .padding()
    }
}

#Preview {
    Example10View()
}
