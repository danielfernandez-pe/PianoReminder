//
//  ButtonStyle.swift
//  
//
//  Created by Daniel Yopla on 21.05.2023.
//

import SwiftUI
import UI

extension Icons {
    public struct ButtonImage: View {
        let icon: Icons.Medium
        let color: Color
        let isDark: Bool

        public init(icon: Icons.Medium, color: Color, isDark: Bool) {
            self.icon = icon
            self.color = color
            self.isDark = isDark
        }

        public var body: some View {
            icon.image
                .foregroundStyle(color)
                .if(isDark) { $0.environment(\.colorScheme, .dark) }
        }
    }
}

extension ButtonStyle where Self == MainButtonStyle<Icons.ButtonImage> {
    public static var primary: MainButtonStyle<Icons.ButtonImage> {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .fgPurple,
                pressedBackgroundColor: .fgPurplePressed,
                isDark: true,
                icon: nil
            )
        )
    }

    public static var game: MainButtonStyle<Icons.ButtonImage> {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .bgPrimary,
                pressedBackgroundColor: .bgPrimary.opacity(0.6),
                isDark: false,
                icon: nil
            )
        )
    }

    public static var correctAnswer: MainButtonStyle<Icons.ButtonImage> {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .fgSuccess,
                pressedBackgroundColor: .fgSuccess.opacity(0.6),
                isDark: true,
                icon: {
                    Icons.ButtonImage(
                        icon: .check,
                        color: .fgPrimary,
                        isDark: true
                    )
                }
            )
        )
    }

    public static var wrongAnswer: MainButtonStyle<Icons.ButtonImage> {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .fgError,
                pressedBackgroundColor: .fgError.opacity(0.6),
                isDark: true,
                icon: {
                    Icons.ButtonImage(
                        icon: .cross,
                        color: .fgPrimary,
                        isDark: true
                    )
                }
            )
        )
    }
}

fileprivate func getDefaultStyle(textColor: Color,
                                 backgroundColor: Color,
                                 pressedBackgroundColor: Color,
                                 isDark: Bool,
                                 icon: (() -> Icons.ButtonImage)?) -> MainButtonStyle<Icons.ButtonImage>.Style {
    .init(
        textColor: textColor,
        backgroundColor: backgroundColor,
        pressedBackgroundColor: pressedBackgroundColor,
        uiFont: ScalingType.body.font(weight: .regular),
        cornerRadius: 8,
        shouldScaleWhenPressed: false,
        isDark: isDark,
        icon: icon
    )
}

#Preview {
    VStack {
        Button("Default extraSmall") {
            print("tap")
        }
        .buttonStyle(.primary)
        .environment(\.sizeCategory, .extraSmall)
        
        Button("Default") {
            print("tap")
        }
        .buttonStyle(.primary)
        
        Button("Default extraExtraLarge") {
            print("tap")
        }
        .buttonStyle(.primary)
        .environment(\.sizeCategory, .extraExtraExtraLarge)

        Button("Correct answer") {
            print("tap")
        }
        .buttonStyle(.correctAnswer)

        Button("Correct answer") {
            print("tap")
        }
        .buttonStyle(.wrongAnswer)
    }
}
