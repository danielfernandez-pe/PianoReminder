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
    public static var fgBlue = Color("blue", bundle: .module)
    public static var fgSuccess = Color("success", bundle: .module)
    public static var fgError = Color("error", bundle: .module)
    public static var fgYellowLight = Color("yellow-light", bundle: .module)
    public static var fgYellowDark = Color("yellow-dark", bundle: .module)
    public static var fgPurple = Color("purple", bundle: .module)
    public static var fgPurpleDisabled = Color("purpleDisabled", bundle: .module)
    public static var fgPurplePressed = Color("purplePressed", bundle: .module)

    // Background
    public static var bgPrimary = Color("bgPrimary", bundle: .module)
    public static var bgSecondary = Color("bgSecondary", bundle: .module)
    public static var bgBlue = Color("bgBlue", bundle: .module)

    // Others
    public static var shadow = Color("shadow", bundle: .module)
    
    // Specifics
    public static var spWhite = Color("spWhite", bundle: .module)
    public static var spBlack = Color("spBlack", bundle: .module)
}
