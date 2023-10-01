//
//  ButtonStyle.swift
//  
//
//  Created by Daniel Yopla on 21.05.2023.
//

import SwiftUI
import UI

extension ButtonStyle where Self == MainButtonStyle {
    public static var primary: MainButtonStyle {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .fgAccent,
                pressedBackgroundColor: .fgAccentPressed,
                isDark: true
            )
        )
    }

    public static var game: MainButtonStyle {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .bgPrimary,
                pressedBackgroundColor: .bgPrimary.opacity(0.6),
                isDark: false
            )
        )
    }

    public static var correctAnswer: MainButtonStyle {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .fgSuccess,
                pressedBackgroundColor: .fgSuccess.opacity(0.6),
                isDark: true
            )
        )
    }

    public static var wrongAnswer: MainButtonStyle {
        MainButtonStyle(
            style: getDefaultStyle(
                textColor: .fgPrimary,
                backgroundColor: .fgError,
                pressedBackgroundColor: .fgError.opacity(0.6),
                isDark: true
            )
        )
    }
}

fileprivate func getDefaultStyle(textColor: Color,
                                 backgroundColor: Color,
                                 pressedBackgroundColor: Color,
                                 isDark: Bool) -> MainButtonStyle.Style {
    .init(
        textColor: textColor,
        backgroundColor: backgroundColor,
        pressedBackgroundColor: pressedBackgroundColor,
        uiFont: ScalingType.body.font(weight: .regular),
        cornerRadius: 8,
        shouldScaleWhenPressed: false,
        isDark: isDark
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
    }
}
