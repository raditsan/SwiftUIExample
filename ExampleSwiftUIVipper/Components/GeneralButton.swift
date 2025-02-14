//
//  GeneralButton.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 12/02/25.
//

import SwiftUI

struct GeneralButton: View {
    enum ButtonType {
        case gradient
        case outlined
        case solid
    }
    
    enum ButtonSize {
        case large
        case normal
        case small
        case custom(CGFloat)
    }
    
    let title: String
    let type: ButtonType
    let action: () -> Void
    
    private var textPadding: EdgeInsets?
    private var textColor = Color.blue
    private var textColorInverted = Color.white
    private var borderColor = Color.blue
    private var borderWidth: CGFloat = 2
    private var backgroundColor = Color.blue
    private var backgroundGradientColors = [Color.blue, Color.purple]
    private var cornerRadius: CGFloat = 8
    private var isEnabled: Bool = true
    private var size: ButtonSize = .normal
    private var font: Font?
    private var leftIconImage: Image? = nil
    private var leftIconTint: Color? = nil
    private var leftIconSize: CGFloat = 20
    private var rightIconImage: Image? = nil
    private var rightIconTint: Color? = nil
    private var rightIconSize: CGFloat = 20
    
    
    init(
        title: String,
        type: ButtonType = .solid,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.type = type
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let leftIcon = leftIconImage {
                    leftIcon
                        .resizable()
                        .frame(width: leftIconSize, height: leftIconSize)
                        .tint(getLeftTintColor())
                }
                
                Text(title)
                    .font(getFont())
                    .foregroundColor(getTextColor())
                
                if let rightIcon = rightIconImage {
                    rightIcon
                        .resizable()
                        .frame(width: rightIconSize, height: rightIconSize)
                        .tint(getRightTintColor())
                }
            }
                .padding(getPadding())
                .frame(maxWidth: .infinity)
                .background(buttonBackground)
                .cornerRadius(cornerRadius)
                .overlay(
                    type == .outlined ? RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth) : nil
                )
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.6)
    }
    
    @ViewBuilder
    private var buttonBackground: some View {
        switch type {
        case .gradient:
            LinearGradient(gradient: Gradient(colors: backgroundGradientColors), startPoint: .leading, endPoint: .trailing)
        case .outlined:
            Color.clear
        case .solid:
            backgroundColor
        }
    }
    
    private func getLeftTintColor() -> Color {
        if let leftIconTint = leftIconTint {
            return leftIconTint
        }
        return type == .outlined ? textColor : textColorInverted
    }
    
    private func getRightTintColor() -> Color {
        if let leftIconTint = leftIconTint {
            return leftIconTint
        }
        return type == .outlined ? textColor : textColorInverted
    }
    
    private func getTextColor() -> Color {
        return type == .outlined ? textColor : textColorInverted
    }
    
    private func getPadding() -> EdgeInsets {
        if let textPadding = self.textPadding {
            return textPadding
        }
        switch size {
        case .large:
            return EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        case .normal:
            return EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        case .small:
            return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        case .custom(let value):
            return EdgeInsets(top: value, leading: value * 1.5, bottom: value, trailing: value * 1.5)
        }
    }
    
    private func getFont() -> Font {
        if let font = self.font {
            return font
        }
        switch size {
        case .large:
            return .title
        case .normal:
            return .headline
        case .small:
            return .subheadline
        case .custom(let value):
            return .system(size: value, weight: .medium, design: .default)
        }
    }
}

extension GeneralButton {
    func setTextColor(_ color: Color, _ invertedColor: Color? = nil) -> GeneralButton {
        var copy = self
        copy.textColor = color
        copy.textColorInverted = invertedColor ?? copy.textColorInverted
        return copy
    }
    func setBorderWidth(_ width: CGFloat) -> GeneralButton {
        var copy = self
        copy.borderWidth = width
        return copy
    }
    func setBorderColor(_ color: Color) -> GeneralButton {
        var copy = self
        copy.borderColor = color
        return copy
    }
    func setBackgroundColor(_ color: Color) -> GeneralButton {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    func setBackgroundGradientColor(_ colors: [Color]) -> GeneralButton {
        var copy = self
        if self.type == .gradient {
            copy.backgroundGradientColors = colors
        }
        return copy
    }
    func setCornerRadius(_ radius: CGFloat) -> GeneralButton {
        var copy = self
        copy.cornerRadius = radius
        return copy
    }
    func setEenabled(_ enabled: Bool) -> GeneralButton {
        var copy = self
        copy.isEnabled = enabled
        return copy
    }
    func setSize(_ size: ButtonSize) -> GeneralButton {
        var copy = self
        copy.size = size
        return copy
    }
    func setFont(_ font: Font?) -> GeneralButton {
        var copy = self
        copy.font = font
        return copy
    }
    func setLeftIcon(_ icon: Image, size: CGFloat? = nil) -> GeneralButton {
        var copy = self
        copy.leftIconImage = icon
        copy.leftIconSize = size ?? copy.leftIconSize
        return copy
    }
    func setRightIcon(_ icon: Image, size: CGFloat? = nil) -> GeneralButton {
        var copy = self
        copy.rightIconImage = icon
        copy.rightIconSize = size ?? copy.rightIconSize
        return copy
    }
}
