//
//  ButtonStyle.swift
//  
//
//  Created by Daniel Yopla on 21.05.2023.
//

import SwiftUI
import UI

extension ButtonStyle where Self == MainButtonStyle {
    public static var main: MainButtonStyle {
        MainButtonStyle(textColor: .white, backgroundColor: .blue)
    }

    public static var correctAnswer: MainButtonStyle {
        MainButtonStyle(textColor: .white, backgroundColor: .green)
    }

    public static var wrongAnswer: MainButtonStyle {
        MainButtonStyle(textColor: .white, backgroundColor: .red)
    }
}
