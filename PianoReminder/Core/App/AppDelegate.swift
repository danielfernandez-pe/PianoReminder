// 
//  AppDelegate.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import Lumberjack
import DependencyInjection
import Networking
import GameAPI

let logger = DIContainer.shared.resolveService(LumberjackCoordinator.self)

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        DependencyInjection.setup()
        FirebaseInit.initializeFirebase(with: "GoogleService-Info")
        sync()
        return true
    }

    private func sync() {
        let syncUseCase = DIContainer.shared.resolveService(SyncGameDataUseCaseType.self)

        Task {
            await syncUseCase.sync()
        }
    }
}
