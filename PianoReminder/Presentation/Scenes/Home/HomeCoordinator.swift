//
//  HomeCoordinator.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 16.07.2023.
//

import SwiftUI
import DependencyInjection
import GameAPI
import Game
import Core

public final class HomeCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let container: any DICProtocol
    private var homeController: UIViewController?

    public init(window: UIWindow, container: any DICProtocol) {
        self.window = window
        self.container = container
    }

    public override func start() {
        // put the factory
        let view = HomeScreen<HomeViewModel>(
            viewModel: .init(
                setupGameSessionUseCase: container.resolveService((any SetupGameSessionUseCaseType).self),
                homeRouter: self
            )
        )
        let controller = UIHostingController(rootView: view)
        homeController = controller
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}

extension HomeCoordinator: HomeRouter {
    func openGame() {
        let gameCoordinator = GameCoordinator(presentingController: homeController!, container: container)
        presentCoordinator(gameCoordinator)

        gameCoordinator.coordinatorDidFinish = { [weak self] coordinator in
            self?.releaseCoordinator(coordinator)
        }
    }
}
