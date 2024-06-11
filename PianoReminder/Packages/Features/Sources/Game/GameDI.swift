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
import Networking
import Storage

var logger: LumberjackCoordinator!

public struct GameDI {
    public static func register(container: DICProtocol) {
        logger = container.resolveService(LumberjackCoordinator.self)

        // DATA

        container.registerService(type: GameService.self, scope: .graph) {
            GameService(networking: container.resolveService(FirebaseNetworking.self))
        }

        container.registerService(type: GameStorage.self, scope: .graph) {
            GameStorage()
        }

        container.registerService(type: UserService.self, scope: .graph) {
            UserService()
        }

        container.registerService(type: GameRepositoryType.self, scope: .container) {
            let gameService = container.resolveService(GameService.self)
            let gameStorage = container.resolveService(GameStorage.self)
            return GameRepository(gameService: gameService, gameStorage: gameStorage)
        }

        container.registerService(type: UserSettingsRepositoryType.self, scope: .graph) {
            let userService = container.resolveService(UserService.self)
            return UserSettingsRepository(userService: userService)
        }

        // DOMAIN

        container.registerService(type: GetGameSettingsUseCaseType.self, scope: .graph) {
            GetGameSettingsUseCase(userSettingsRepository: container.resolveService(UserSettingsRepositoryType.self))
        }
        
        container.registerService(type: GetQuestionsUseCaseType.self, scope: .graph) {
            GetQuestionsUseCase(
                getGameSettingsUseCase: container.resolveService(GetGameSettingsUseCaseType.self),
                gameRepository: container.resolveService(GameRepositoryType.self)
            )
        }

        container.registerService(type: SyncGameDataUseCaseType.self, scope: .graph) {
            SyncGameDataUseCase(
                gameRepository: container.resolveService(GameRepositoryType.self),
                userDefaultsService: container.resolveService(UserDefaultsService.self)
            )
        }

        container.registerService(type: GameManagerType.self, scope: .graph) {
            GameManager(getQuestionsUseCase: container.resolveService(GetQuestionsUseCaseType.self))
        }

        // PRESENTATION

        container.registerService(type: GameViewModel.self, scope: .graph) {
            GameViewModel(
                gameManager: container.resolveService(GameManagerType.self)
            )
        }

        container.registerService(type: GameOverviewViewModel.self, scope: .graph) { correctQuestions in
            GameOverviewViewModel(correctQuestions: correctQuestions)
        }
    }
}
