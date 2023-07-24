//
//  getGameController.swift
//
//
//  Created by Daniel Yopla on 16.07.2023.
//

import SwiftUI
import DependencyInjection

final class GameFactory {
    static func getGameController(container: DICProtocol, router: any GameRouter) -> UIViewController {
        let view = container.resolveService(GameScreen<GameViewModel>.self)
        view.viewModel.router = router
        let controller = UIHostingController(rootView: view)
        return controller
    }

    static func getGameOverviewController(container: DICProtocol, router: any GameOverviewRouter) -> UIViewController {
        let view = container.resolveService(GameOverviewScreen<GameOverviewViewModel>.self)
        view.viewModel.router = router
        let controller = UIHostingController(rootView: view)
        return controller
    }
}
