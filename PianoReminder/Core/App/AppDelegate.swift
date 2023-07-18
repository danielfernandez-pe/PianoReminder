// 
//  AppDelegate.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import Logger

let logger = Logger(label: "PianoReminder")

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        DependencyInjection.setup()
        return true
    }
}
