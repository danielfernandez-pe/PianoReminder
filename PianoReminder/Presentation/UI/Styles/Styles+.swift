//
//  Styles+.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 26.04.2023.
//

import SwiftUI
import UI

extension ButtonStyle where Self == MainButtonStyle {
    public static var main: MainButtonStyle {
        MainButtonStyle(textColor: .white, backgroundColor: .blue)
    }
}
