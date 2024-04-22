//
//  GameCoordinator.swift
//
//
//  Created by Daniel Yopla on 16.07.2023.
//

import UIKit
import Combine
import DependencyInjection
import Core

public final class GameCoordinator: BaseCoordinator {
    private let presentingController: UIViewController
    private let container: any DICProtocol
    private let navigationController = UINavigationController()
    private var cancellables = Set<AnyCancellable>()

    public init(presentingController: UIViewController, container: any DICProtocol) {
        self.presentingController = presentingController
        self.container = container
        super.init()
    }

    public override func start() {
        let gameViewModel = GameFactory.getGameViewModel(container: container)
        let gameController = GameFactory.getGameController(container: container, viewModel: gameViewModel)
        navigationController.viewControllers = [gameController]
        navigationController.modalPresentationStyle = .fullScreen

        presentingController.present(navigationController, animated: true)

        gameViewModel
            .routing
            .sink { [weak self] route in
                switch route {
                case .overview(let correctQuestions):
                    self?.openOverview(correctQuestions: correctQuestions)
                }
            }
            .store(in: &cancellables)
    }

    private func openOverview(correctQuestions: [QuestionDOM]) {
        let gameOverviewViewModel = GameOverviewFactory.getGameOverviewViewModel(container: container, correctQuestions: correctQuestions)
        let gameOverviewController = GameOverviewFactory.getGameOverviewController(container: container, viewModel: gameOverviewViewModel)
        navigationController.pushViewController(gameOverviewController, animated: true)
        
        gameOverviewViewModel
            .routing
            .sink { [weak self] route in
                guard let self else { return }
                switch route {
                case .close:
                    presentingController.dismiss(animated: true) {
                        self.coordinatorDidFinish?(self)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
