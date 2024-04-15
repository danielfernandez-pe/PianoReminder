//
//  File.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation
import DependencyInjection
import GameAPI

// TODO: delete unused use cases
// swiftlint:disable force_cast identifier_name
public struct GameDI {
    public static func register(container: DICProtocol) {
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

        container.registerService(type: GetGameSettingsUseCase.self, scope: .graph) { r in
            GetGameSettingsUseCase(userSettingsRepository: r.resolveService((any UserSettingsRepositoryType).self))
        }
        
        container.registerService(type: GetQuestionsUseCase.self, scope: .graph) { r in
            GetQuestionsUseCase(
                userSettingsRepository: r.resolveService((any UserSettingsRepositoryType).self),
                gameRepository: r.resolveService((any GameRepositoryType).self)
            )
        }

        container.registerService(type: (any SyncGameDataUseCaseType).self, scope: .graph) { r in
            SyncGameDataUseCase(gameRepository: r.resolveService((any GameRepositoryType).self))
        }

        container.registerService(type: GameManager.self, scope: .graph) { r in
            GameManager(getQuestionsUseCase: r.resolveService(GetQuestionsUseCase.self))
        }

        // PRESENTATION

        container.registerService(type: GameViewModel.self, scope: .graph) { r in
            GameViewModel(
                gameManager: r.resolveService(GameManager.self)
            )
        }

        container.registerService(type: GameOverviewViewModel.self, scope: .graph) { r in
            GameOverviewViewModel()
        }
    }
}
// swiftlint:enable force_cast identifier_name
