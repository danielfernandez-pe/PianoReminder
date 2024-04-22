//
//  GameOverviewFactory.swift
//
//
//  Created by Daniel Yopla on 24.07.2023.
//

import SwiftUI
import DependencyInjection

final class GameOverviewFactory {
    static func getGameOverviewController(container: DICProtocol, viewModel: GameOverviewViewModel) -> UIViewController {
        let view = GameOverviewScreen<GameOverviewViewModel>(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        return controller
    }

    static func getGameOverviewViewModel(container: DICProtocol, correctQuestions: [QuestionDOM]) -> GameOverviewViewModel {
        container.resolveService(GameOverviewViewModel.self, arg1: correctQuestions)
    }
}
