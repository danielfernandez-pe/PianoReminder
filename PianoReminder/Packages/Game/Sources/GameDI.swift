//
//  File.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation
import DependencyInjection
import GameAPI

// swiftlint:disable force_cast
public struct GameDI {
    public static func register(container: DICProtocol) {
        // DATA

        container.register(type: GameServiceType.self, service: GameService())
        container.register(type: UserServiceType.self, service: UserService())

        let gameService: GameService = container.resolve(type: GameServiceType.self) as! GameService
        let userService: UserService = container.resolve(type: UserServiceType.self) as! UserService

        container.register(type: (any GameRepositoryType).self, service: GameRepository<GameService>(gameService: gameService))
        container.register(type: (any UserSettingsRepositoryType).self, service: UserSettingsRepository<UserService>(userService: userService))

        // DOMAIN

        container.register(
            type: GetChordQuestionUseCase.self,
            service: GetChordQuestionUseCase(gameRepository: container.resolve(type: (any GameRepositoryType).self))
        )

        container.register(
            type: GetGameTypeUseCase.self,
            service: GetGameTypeUseCase(userSettingsRepository: container.resolve(type: (any UserSettingsRepositoryType).self))
        )

        container.register(
            type: GetNoteQuestionUseCase.self,
            service: GetNoteQuestionUseCase(gameRepository: container.resolve(type: (any GameRepositoryType).self))
        )

        container.register(
            type: (any SetupGameSessionUseCaseType).self,
            service: SetupGameSessionUseCase(gameRepository: container.resolve(type: (any GameRepositoryType).self))
        )

        // PRESENTATION

        container.register(type: GameRouter.self, service: GameRouter(container: container))

        container.register(
            type: (any GameViewModelType).self,
            service: GameViewModel(
                getNoteQuestionUseCase: container.resolve(type: GetNoteQuestionUseCase.self),
                getChordQuestionUseCase: container.resolve(type: GetChordQuestionUseCase.self),
                getGameTypeUseCase: container.resolve(type: GetGameTypeUseCase.self),
                router: container.resolve(type: GameRouter.self)
            )
        )

        let gameViewModel: GameViewModel = container.resolve(type: (any GameViewModelType).self) as! GameViewModel

        container.register(
            type: GameScreen<GameViewModel>.self,
            service: GameScreen<GameViewModel>(viewModel: gameViewModel)
        )

        container.register(type: (any GameOverviewViewModelType).self, service: GameOverviewViewModel())

        let gameOverviewViewModel: GameOverviewViewModel = container.resolve(type: (any GameOverviewViewModelType).self) as! GameOverviewViewModel

        container.register(
            type: GameOverviewScreen<GameOverviewViewModel>.self,
            service: GameOverviewScreen<GameOverviewViewModel>(viewModel: gameOverviewViewModel)
        )
    }
}
// swiftlint:enable force_cast
