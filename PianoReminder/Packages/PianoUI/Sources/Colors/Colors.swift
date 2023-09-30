//
//  Colors.swift
//
//
//  Created by Daniel Yopla on 30.09.2023.
//

import SwiftUI

extension Color {
    // Foreground
    static var fgPrimary = Color("primary", bundle: .module)
    static var fgSecondary = Color("secondary", bundle: .module)
    static var fgDisabled = Color("disabled", bundle: .module)
    static var fgAccent = Color("accent", bundle: .module)
    static var fgAccentDisabled = Color("accent-disabled", bundle: .module)
    static var fgAccentPressed = Color("accent-pressed", bundle: .module)
    static var fgSuccess = Color("success", bundle: .module)
    static var fgError = Color("error", bundle: .module)
    static var fgYellowLight = Color("yellow-light", bundle: .module)
    static var fgYellowDark = Color("yellow-dark", bundle: .module)
    static var fgPurple = Color("purple", bundle: .module)
    
    // Background
    static var bgPrimary = Color("bg-primary", bundle: .module)
    static var bgSecondary = Color("bg-secondary", bundle: .module)
    static var bgAccent = Color("bg-accent", bundle: .module)
}
