//
//  GameCoordinator.swift
//
//
//  Created by Daniel Yopla on 16.07.2023.
//

import UIKit
import DependencyInjection
import Core

public final class GameCoordinator: BaseCoordinator {
    private let presentedController: UIViewController
    private let container: any DICProtocol
    private let navigationController = UINavigationController()

    public init(presentedController: UIViewController, container: any DICProtocol) {
        self.presentedController = presentedController
        self.container = container
        super.init()
    }

    public override func start() {
        let gameController = GameFactory.getGameController(container: container, router: self)
        navigationController.viewControllers = [gameController]
        navigationController.modalPresentationStyle = .fullScreen
        presentedController.present(navigationController, animated: true)
    }
}

extension GameCoordinator: GameRouter {
    func openOverview() {
        let gameOverviewController = GameFactory.getGameOverviewController(container: container, router: self)
        navigationController.pushViewController(gameOverviewController, animated: true)
    }
}

extension GameCoordinator: GameOverviewRouter {
    func closeGame() {
        presentedController.dismiss(animated: true) {
            self.coordinatorDidFinish?(self)
        }
    }
}
