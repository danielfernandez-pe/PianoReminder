//
//  Colors.swift
//
//
//  Created by Daniel Yopla on 30.09.2023.
//

import SwiftUI

extension Color {
    // Foreground
    public static var fgPrimary = Color("primary", bundle: .module)
    public static var fgSecondary = Color("secondary", bundle: .module)
    public static var fgDisabled = Color("disabled", bundle: .module)
    public static var fgAccent = Color("accent", bundle: .module)
    public static var fgAccentDisabled = Color("accent-disabled", bundle: .module)
    public static var fgAccentPressed = Color("accent-pressed", bundle: .module)
    public static var fgSuccess = Color("success", bundle: .module)
    public static var fgError = Color("error", bundle: .module)
    public static var fgYellowLight = Color("yellow-light", bundle: .module)
    public static var fgYellowDark = Color("yellow-dark", bundle: .module)
    public static var fgPurple = Color("purple", bundle: .module)

    // Background
    public static var bgPrimary = Color("bg-primary", bundle: .module)
    public static var bgSecondary = Color("bg-secondary", bundle: .module)
    public static var bgAccent = Color("bg-accent", bundle: .module)

    // Others
    public static var shadow = Color("shadow", bundle: .module)
}
