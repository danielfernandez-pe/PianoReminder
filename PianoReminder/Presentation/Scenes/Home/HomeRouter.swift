//
//  HomeRouter.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Combine
import Core
import Game
import SwiftUI

final class HomeRouter: Router<HomeRouter.Path>, ObservableObject {
    enum Path {
        case game

        var screen: some View {
            switch self {
            case .game:
                return GameScreen<GameViewModel>(
                    viewModel: GameViewModel(
                        gameRepository: DIContainer.shared.resolve(type: (any GameRepositoryType).self),
                        userSettingsRepository: DIContainer.shared.resolve(type: (any UserSettingsRepositoryType).self)
                    )
                )
            }
        }
    }
}
