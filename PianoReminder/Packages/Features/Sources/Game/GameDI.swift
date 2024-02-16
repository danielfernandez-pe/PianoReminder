//
//  File.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation
import DependencyInjection
import GameAPI

// swiftlint:disable force_cast identifier_name
public struct GameDI {
    public static func register(container: DICProtocol) {
        // DATA

        container.registerService(type: GameServiceType.self, scope: .graph) { _ in
            GameService()
        }

        container.registerService(type: UserServiceType.self, scope: .graph) { _ in
            UserService()
        }

        container.registerService(type: (any GameRepositoryType).self, scope: .container) { r in
            let gameService: GameService = r.resolveService(GameServiceType.self) as! GameService
            return GameRepository<GameService>(gameService: gameService)
        }

        container.registerService(type: (any UserSettingsRepositoryType).self, scope: .graph) { r in
            let userService: UserService = r.resolveService(UserServiceType.self) as! UserService
            return UserSettingsRepository<UserService>(userService: userService)
        }

        // DOMAIN

        container.registerService(type: GetChordQuestionUseCase.self, scope: .graph) { r in
            GetChordQuestionUseCase(gameRepository: r.resolveService((any GameRepositoryType).self))
        }

        container.registerService(type: GetGameTypeUseCase.self, scope: .graph) { r in
            GetGameTypeUseCase(userSettingsRepository: r.resolveService((any UserSettingsRepositoryType).self))
        }

        container.registerService(type: GetNoteQuestionUseCase.self, scope: .graph) { r in
            GetNoteQuestionUseCase(gameRepository: r.resolveService((any GameRepositoryType).self))
        }

        container.registerService(type: (any SetupGameSessionUseCaseType).self, scope: .graph) { r in
            SetupGameSessionUseCase(gameRepository: r.resolveService((any GameRepositoryType).self))
        }

        // PRESENTATION

        container.registerService(type: GameViewModel.self, scope: .graph) { r in
            GameViewModel(
                getNoteQuestionUseCase: r.resolveService(GetNoteQuestionUseCase.self),
                getChordQuestionUseCase: r.resolveService(GetChordQuestionUseCase.self),
                getGameTypeUseCase: r.resolveService(GetGameTypeUseCase.self)
            )
        }

        container.registerService(type: GameOverviewViewModel.self, scope: .graph) { r in
            GameOverviewViewModel()
        }
    }
}
// swiftlint:enable force_cast identifier_name
