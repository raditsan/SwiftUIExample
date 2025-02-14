//
//  Example6View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 12/02/25.
//

import SwiftUI

class ExampleButtonState: ObservableObject {
    @Published var selectedButtonTypeIndex = 0
    @Published var selectedRadiusIndex = 0
}
struct Example6View: View {
    var buttonTypes = [
        GeneralButton.ButtonType.solid,
        GeneralButton.ButtonType.gradient,
        GeneralButton.ButtonType.outlined,
    ]
    var buttonRadius: [CGFloat] = [10, 0, 30, 20]
    @StateObject var buttonState = ExampleButtonState()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                GeneralButton(title: "Example Button", type: buttonTypes[buttonState.selectedButtonTypeIndex]) {
                    if buttonState.selectedButtonTypeIndex == buttonTypes.count - 1 {
                        buttonState.selectedButtonTypeIndex = 0
                    } else {
                        buttonState.selectedButtonTypeIndex += 1
                    }
                    
                    if buttonState.selectedRadiusIndex == buttonRadius.count - 1 {
                        buttonState.selectedRadiusIndex = 0
                    } else {
                        buttonState.selectedRadiusIndex += 1
                    }
                }
                .setCornerRadius(buttonRadius[buttonState.selectedRadiusIndex])
                
                GeneralButton(title: "Icon Left", type: .solid) {
                    
                }
                .setBackgroundColor(.red)
                .setLeftIcon(Image(systemName: "arrow.left"))
                
                GeneralButton(title: "Icon Right", type: .solid) {
                    
                }
                .setRightIcon(Image(systemName: "arrow.right"))
                
                GeneralButton(title: "Icon Right", type: .solid) {
                    
                }
                .setLeftIcon(Image(systemName: "arrow.left"), size: 35)
                .setRightIcon(Image(systemName: "arrow.right"), size: 14)
                
                GeneralButton(title: "Size Small", type: .solid) {
                    
                }
                .setSize(.small)
                
                GeneralButton(title: "Size Normal", type: .solid) {
                    
                }
                .setSize(.normal)
                
                GeneralButton(title: "Size Large", type: .solid) {
                    
                }
                .setSize(.large)
                
                GeneralButton(title: "Size Custom", type: .solid) {
                    
                }
                .setSize(.custom(10))
                
                GeneralButton(title: "Gradient Button", type: .gradient) {
                    print("Gradient Button Tapped")
                }
                
                GeneralButton(title: "Gradient Button 2", type: .gradient) {
                    print("Gradient Button Tapped")
                }
                .setBackgroundGradientColor([.red, .blue])
                .setCornerRadius(12)
                
                GeneralButton(title: "Outlined Button", type: .outlined) {
                    print("Outlined Button Tapped")
                }
                .setCornerRadius(30)
                
                GeneralButton(title: "Outlined Button 2", type: .outlined) {
                    print("Outlined Button Tapped")
                }
                .setBorderColor(.red)
                .setTextColor(.yellow)
                .setCornerRadius(30)
                
                GeneralButton(title: "Outlined Button 3", type: .outlined) {
                    print("Outlined Button Tapped")
                }
                .setBorderWidth(10)
                
                GeneralButton(title: "Solid Button", type: .solid) {
                    print("Solid Button Tapped")
                }
                
                GeneralButton(title: "Disabled Button", type: .solid) {
                    print("Solid Button Tapped")
                }
                .setEenabled(false)
            }
            .padding()
        }
    }
}

#Preview {
    Example6View()
}
