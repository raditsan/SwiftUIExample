//
//  NumberTextFieldView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 14/02/25.
//

//import SwiftUI

//struct NumberTextFieldView: View {
//    @Binding var value: String
//    var placeholder: String
//    
//    var body: some View {
//        TextField(placeholder, text: $value)
//            .keyboardType(.numberPad)
//            .onChange(of: value) { newValue in
//                value = formatNumber(newValue)
//            }
//    }
//    
//    private func formatNumber(_ number: String) -> String {
//        // Remove any non-numeric characters
//        let cleanedNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        
//        // Format the number (e.g., add commas)
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        
//        if let formattedNumber = formatter.string(from: NSNumber(value: Double(cleanedNumber) ?? 0)) {
//            return formattedNumber
//        }
//        
//        return cleanedNumber
//    }
//}

//struct NumberTextFieldView: UIViewRepresentable {
//    @Binding var value: String
//    var placeholder: String
//    
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField()
//        textField.delegate = context.coordinator
//        textField.keyboardType = .numberPad
//        textField.placeholder = placeholder
//        textField.text = value
//        return textField
//    }
//    
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.text = value
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var parent: NumberTextFieldView
//        
//        init(_ parent: NumberTextFieldView) {
//            self.parent = parent
//        }
//        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            // Get the current text and apply the replacement
//            let currentText = textField.text ?? ""
//            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//            
//            // Remove non-numeric characters
//            let cleanedText = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//            
//            // Format the number
//            let formattedText = formatNumber(cleanedText)
//            
//            // Update the binding value
//            parent.value = formattedText
//            
//            // Calculate the new cursor position
//            let offset = formattedText.count - currentText.count
//            if let selectedRange = textField.selectedTextRange {
//                let newPosition = textField.position(from: selectedRange.start, offset: offset) ?? selectedRange.start
//                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
//            }
//            
//            return false // Prevent default behavior
//        }
//        
//        private func formatNumber(_ number: String) -> String {
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            
//            if let formattedNumber = formatter.string(from: NSNumber(value: Double(number) ?? 0)) {
//                return formattedNumber
//            }
//            return number
//        }
//    }
//}

//struct NumberTextFieldView: UIViewRepresentable {
//    @Binding var text: String
//    @State private var cursorPosition: Int = 0
//
//    private let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.groupingSeparator = ","
//        formatter.decimalSeparator = "."
//        return formatter
//    }()
//
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField()
//        textField.keyboardType = .decimalPad
//        textField.delegate = context.coordinator
//        textField.text = formattedText(for: text)
//        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
//        return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.text = formattedText(for: text)
//        setCursorPosition(in: uiView)
//    }
//
//    private func formattedText(for input: String) -> String {
//        let numericString = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
////        if let number = Double(numericString), let formatted = formatter.string(from: NSNumber(value: number)) {
////            return formatted
////        }
////        return input // Fallback to raw input if formatting fails
//        guard !numericString.isEmpty else { return input }
//        
//        var result = ""
//        var count = 0
//        
//        // Iterate through digits from right to left and insert commas
//        for char in numericString.reversed() {
//            if count > 0 && count % 3 == 0 {
//                result.append(",")
//            }
//            result.append(char)
//            count += 1
//        }
//        
//        return String(result.reversed())
//    }
//
//    private func setCursorPosition(in textField: UITextField) {
//        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: cursorPosition) {
//            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var parent: NumberTextFieldView
//
//        init(_ parent: NumberTextFieldView) {
//            self.parent = parent
//        }
//
//        @objc func textFieldDidChange(_ textField: UITextField) {
//            if let text = textField.text {
//                // Update the raw text (without formatting)
//                let numericString = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
//                
//                let formattedText = parent.formattedText(for: numericString)
//                parent.text = formattedText
//                
//                if let selectedRange = textField.selectedTextRange {
//                    var cursorOffset = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)
//                    if formattedText.count > text.count && cursorOffset != 1 {
//                        cursorOffset += 1
//                    } else if  formattedText.count < text.count && cursorOffset != 0 {
//                        cursorOffset -= 1
//                    }
//                    parent.cursorPosition = cursorOffset
//                }
//            }
//        }
//        
//        func isSingleDigitBeforeComma(_ text: String) -> Bool {
//            let pattern = #"^\d{1},.*$"#
//            return text.range(of: pattern, options: .regularExpression) != nil
//        }
//        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            
//            if string.isEmpty {
//                if let text = textField.text, let rangeStart = text.index(text.startIndex, offsetBy: range.location, limitedBy: text.endIndex),
//                   let rangeEnd = text.index(rangeStart, offsetBy: range.length, limitedBy: text.endIndex) {
//                    let substring = text[rangeStart..<rangeEnd]
//                    if substring == "," {
//                        if range.location > 0 {
//                            var textArray = Array(text)
//                            textArray.remove(at: range.location - 1) // Remove the number before the comma
//                            textArray.remove(at: range.location - 1) // Remove the comma
//                            let newText = String(textArray)
////                            textField.text = newText
//                            parent.text = newText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
//                            parent.cursorPosition = range.location - (isSingleDigitBeforeComma(text) && range.location > 1 ? 2 : 1)
//                            return false
//                        }
//                    }
//                }
//            }
//            return true
//        }
//    }
//}

import SwiftUI

struct NumberTextFieldView: UIViewRepresentable {
    @Binding var text: String
    @State private var cursorPosition: Int = 0
    var groupingSeparator: Character
    var decimalSeparator: Character
    private var onValueChange: ((String) -> Void)? = nil

    init(text: Binding<String>, groupingSeparator: Character = ",", decimalSeparator: Character = ".") {
        self._text = text
        self.groupingSeparator = groupingSeparator
        self.decimalSeparator = decimalSeparator
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.delegate = context.coordinator
        textField.text = formattedText(for: text)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        onValueChange?(resultValue())
        uiView.text = formattedText(for: text)
        setCursorPosition(in: uiView)
    }
    
    private func resultValue() -> String {
        var result = replacingExpression(text)
        if result == "" {
            result = "0"
        } else if result.hasSuffix(String(decimalSeparator)) {
            result.removeLast()
        }
        return result
    }
    
    private func replacingExpression(_ value: String) -> String {
        return value.replacingOccurrences(of: "[^0-9\(decimalSeparator)]", with: "", options: .regularExpression)
    }
    
    private func formattedText(for input: String) -> String {
        // Keep decimals but strip unwanted characters
        let numericString = replacingExpression(input)
        if numericString.hasPrefix("0\(decimalSeparator)") {
            return numericString
        }
        if numericString.filter({$0 == decimalSeparator}).count == 1 && numericString.hasSuffix("\(decimalSeparator)") {
            return formatWithCommas(numericString) + String(decimalSeparator)
        }
        // If input starts with '0' but followed by a digit (e.g., "012" → "12"), remove the leading zero
        if numericString.hasPrefix("0") && !numericString.hasPrefix("0\(decimalSeparator)") {
            let trimmed = String(numericString.drop(while: { $0 == "0" })) // Remove all leading zeros
            return formatWithCommas(trimmed.isEmpty ? "0" : trimmed) // Ensure at least "0" is returned
        }
        
        return formatWithCommas(numericString)
    }

    // Helper function to add commas to numbers
    private func formatWithCommas(_ numberString: String) -> String {
        guard !numberString.isEmpty else { return "" }

        // If contains a decimal, split into integer and decimal parts
        if numberString.contains(decimalSeparator) {
            let components = numberString.split(separator: decimalSeparator, maxSplits: 1)
            let integerPart = formatIntegerPart(String(components[0]))
            let decimalPart = components.count > 1 ? String(decimalSeparator) + components[1] : ""
            return integerPart + decimalPart
        }

        return formatIntegerPart(numberString)
    }

    // Helper function to format only the integer part with commas
    private func formatIntegerPart(_ integerPart: String) -> String {
        var result = ""
        var count = 0

        for char in integerPart.reversed() {
            if count > 0 && count % 3 == 0 {
                result.append(groupingSeparator)
            }
            result.append(char)
            count += 1
        }

        return String(result.reversed())
    }

    private func setCursorPosition(in textField: UITextField) {
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: cursorPosition) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NumberTextFieldView
        var decimalSeparator: String {
            return String(parent.decimalSeparator)
        }
        var groupingSeparator: String {
            return String(parent.groupingSeparator)
        }
        init(_ parent: NumberTextFieldView) {
            self.parent = parent
        }
        
        func isSingleDigitBeforeComma(_ text: String) -> Bool {
            let escapedSeparator = NSRegularExpression.escapedPattern(for: groupingSeparator)
            let pattern = #"^\d{1}\#(escapedSeparator).*$"#
            return text.range(of: pattern, options: .regularExpression) != nil
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string.isEmpty {
                if let text = textField.text, let rangeStart = text.index(text.startIndex, offsetBy: range.location, limitedBy: text.endIndex),
                   let rangeEnd = text.index(rangeStart, offsetBy: range.length, limitedBy: text.endIndex) {
                    let substring = text[rangeStart..<rangeEnd]
                    if substring == decimalSeparator {
                        parent.text = parent.replacingExpression(text.components(separatedBy: decimalSeparator)[0])
                        parent.cursorPosition = range.location
                        return false
                    } else if substring == groupingSeparator {
                        if range.location > 0 {
                            var textArray = Array(text)
                            textArray.remove(at: range.location - 1) // Remove the number before the comma
                            textArray.remove(at: range.location - 1) // Remove the comma
                            let newText = String(textArray)
//                            textField.text = newText
                            parent.text = parent.replacingExpression(newText)
                            parent.cursorPosition = range.location - (isSingleDigitBeforeComma(text) && range.location > 1 ? 2 : 1)
                            return false
                        }
                    } else {
                        guard let currentText = textField.text as NSString? else { return false }
                        let newText = currentText.replacingCharacters(in: range, with: string)
                        parent.text = parent.replacingExpression(newText)
//                        parent.cursorPosition = range.location - (isSingleDigitBeforeComma(text) && range.location > 1 ? 1 : 0)
                        if newText.contains(parent.decimalSeparator) {
                            if let decimalSeparatorIndex = newText.components(separatedBy: "").firstIndex(where: {$0 == decimalSeparator}), range.location > decimalSeparatorIndex {
                                parent.cursorPosition = range.location - 1
                            } else {
                                parent.cursorPosition = range.location
                            }
                            
                        } else {
                            parent.cursorPosition = range.location - (isSingleDigitBeforeComma(text) && range.location > 1 ? 1 : 0)
                        }
                        return false
                    }
                }
            } else {
                guard let currentText = textField.text as NSString? else { return false }
                if string == decimalSeparator && currentText.contains(decimalSeparator) {
                    return false
                }
                let newText = currentText.replacingCharacters(in: range, with: string)
                let numericString = parent.replacingExpression(newText)
                let formattedText = parent.formattedText(for: numericString)
                parent.text = formattedText
                
                if let selectedRange = textField.selectedTextRange {
                    var cursorOffset = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)
                    cursorOffset += string.count
                    if formattedText.count > newText.count && cursorOffset != 1 {
                        cursorOffset += 1
                    } else if  formattedText.count < newText.count && cursorOffset != 0 {
                        cursorOffset -= 1
                    }
                    parent.cursorPosition = cursorOffset
                }
                return false
            }
            return true
        }
    }
}

extension NumberTextFieldView {
    func onValueChanged(_ handler: @escaping (String) -> Void) -> Self {
        var copy = self
        copy.onValueChange = handler
        return copy
    }
}
