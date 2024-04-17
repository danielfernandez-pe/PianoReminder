//
//  GameDI.swift
//
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation
import DependencyInjection
import GameAPI
import Lumberjack

var logger: LumberjackCoordinator!

public struct GameDI {
    public static func register(container: DICProtocol) {
        logger = container.resolveService(LumberjackCoordinator.self)
        
        // DATA

        container.registerService(type: GameService.self, scope: .graph) { _ in
            GameService()
        }

        container.registerService(type: GameStorage.self, scope: .graph) { _ in
            GameStorage()
        }

        container.registerService(type: UserService.self, scope: .graph) { _ in
            UserService()
        }

        container.registerService(type: GameRepositoryType.self, scope: .container) { r in
            let gameService = r.resolveService(GameService.self)
            let gameStorage = r.resolveService(GameStorage.self)
            return GameRepository(gameService: gameService, gameStorage: gameStorage)
        }

        container.registerService(type: UserSettingsRepositoryType.self, scope: .graph) { r in
            let userService = r.resolveService(UserService.self)
            return UserSettingsRepository(userService: userService)
        }

        // DOMAIN

        container.registerService(type: GetGameSettingsUseCaseType.self, scope: .graph) { r in
            GetGameSettingsUseCase(userSettingsRepository: r.resolveService(UserSettingsRepositoryType.self))
        }
        
        container.registerService(type: GetQuestionsUseCaseType.self, scope: .graph) { r in
            GetQuestionsUseCase(
                getGameSettingsUseCase: r.resolveService(GetGameSettingsUseCaseType.self),
                gameRepository: r.resolveService(GameRepositoryType.self)
            )
        }

        container.registerService(type: SyncGameDataUseCaseType.self, scope: .graph) { r in
            SyncGameDataUseCase(gameRepository: r.resolveService(GameRepositoryType.self))
        }

        container.registerService(type: GameManagerType.self, scope: .graph) { r in
            GameManager(getQuestionsUseCase: r.resolveService(GetQuestionsUseCaseType.self))
        }

        // PRESENTATION

        container.registerService(type: GameViewModel.self, scope: .graph) { r in
            GameViewModel(
                gameManager: r.resolveService(GameManagerType.self)
            )
        }

        container.registerService(type: GameOverviewViewModel.self, scope: .graph) { r in
            GameOverviewViewModel()
        }
    }
}
