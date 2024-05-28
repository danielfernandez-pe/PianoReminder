//
//  DependencyInjection.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation
import OSLog
import Game
import Storage
import Lumberjack
import Networking
import DependencyInjection

final class DependencyInjection {
    static func setup() {
        Self.registerMainDependencies()
        GameDI.register(container: DIContainer.shared)
        StorageDI.register(container: DIContainer.shared)
    }

    private static func registerMainDependencies() {
        DIContainer.shared.registerService(type: LumberjackCoordinator.self, scope: .container) {
            LumberjackCoordinator(
                loggers: [
                    Logger.main
                ]
            )
        }

        DIContainer.shared.registerService(type: FirebaseNetworking.self, scope: .container) {
            FirebaseNetworking()
        }
    }
}
