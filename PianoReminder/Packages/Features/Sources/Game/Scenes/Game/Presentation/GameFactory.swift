//
//  getGameController.swift
//
//
//  Created by Daniel Yopla on 16.07.2023.
//

import SwiftUI
import DependencyInjection

final class GameFactory {
    static func getGameController(container: DICProtocol, viewModel: GameViewModel) -> UIViewController {
        let view = GameScreen<GameViewModel>(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        return controller
    }

    static func getGameViewModel(container: DICProtocol) -> GameViewModel {
        container.resolveService(GameViewModel.self)
    }
}
