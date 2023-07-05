// 
//  PianoReminderApp.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import GameAPI
import DependencyInjection

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
    @StateObject private var homeRouter: HomeRouter = DIContainer.shared.resolveService(HomeRouter.self)

    var body: some View {
        NavigationStack(path: $homeRouter.paths) {
            HomeScreen<HomeViewModel>(
                viewModel: .init(
                    setupGameSessionUseCase: DIContainer.shared.resolveService((any SetupGameSessionUseCaseType).self),
                    router: homeRouter
                )
            )
        }
    }
}
