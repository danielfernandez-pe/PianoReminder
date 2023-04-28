// 
//  AppDelegate.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import Logger

// swiftlint:disable identifier_name
// let L = R.string.localizable uncomment when adding localization
// swiftlint:enable identifier_name

let logger = Logger(label: "PianoReminder")

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
