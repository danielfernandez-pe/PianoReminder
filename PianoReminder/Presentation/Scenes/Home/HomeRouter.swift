//
//  HomeRouter.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 19.05.2023.
//

import SwiftUI
import Combine
import Core
import Game
import DependencyInjection

public final class HomeRouter: Router<HomeRouter.Path> {
    public enum Path {
        case something
    }

    private let container: any DICProtocol
    private let gameRouter: GameRouter

    public init(container: any DICProtocol) {
        self.container = container
        gameRouter = container.resolve(type: GameRouter.self)
    }

    public func start() -> some View {
//        container.resolve(type: GameScreen<GameViewModel>.self)
        EmptyView()
    }

    func startGame() -> some View {
        gameRouter.start()
    }

    @ViewBuilder
    func currentScreen() -> some View {
        if let last = paths.last {
            switch last {
            case .something:
//                container.resolve(type: GameOverviewScreen<GameOverviewViewModel>.self)
                EmptyView()
            }
        } else {
            fatalError("This shouldn't happen")
        }
    }
}
