// 
//  PianoReminderApp.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import Networking

@main
struct PianoReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var delegate

    var body: some Scene {
        WindowGroup {
            InitialScreen()
        }
    }
}

struct InitialScreen: View {
    var body: some View {
        HomeScreen(viewModel: .init(networking: RestNetworking()))
    }
}
