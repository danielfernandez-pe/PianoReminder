//
//  DependencyInjection.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation
import OSLog
import Game
import Lumberjack
import DependencyInjection

final class DependencyInjection {
    static func setup() {
        GameDI.register(container: DIContainer.shared)

        DIContainer.shared.registerService(type: LumberjackCoordinator.self, scope: .container) { resolver in
            LumberjackCoordinator(
                loggers: [
                    Logger.main
                ]
            )
        }
    }
}
