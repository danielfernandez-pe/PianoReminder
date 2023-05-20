// 
//  PianoReminderApp.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import Game

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
    @StateObject private var homeRouter: HomeRouter = DIContainer.shared.resolve(type: HomeRouter.self)

    var body: some View {
        NavigationStack(path: $homeRouter.paths) {
            HomeScreen<HomeViewModel>(
                viewModel: .init(
                    gameRepository: DIContainer.shared.resolve(type: (any GameRepositoryType).self),
                    router: homeRouter
                )
            )
        }
    }
}
