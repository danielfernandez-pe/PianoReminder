//
//  GameRouter.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Core
import SwiftUI
import DependencyInjection

public final class GameRouter: Router<GameRouter.Path> {
    public enum Path {
        case overview
    }

    private let container: any DICProtocol

    public init(container: any DICProtocol) {
        self.container = container
    }

    public func start() -> some View {
        container.resolve(type: GameScreen<GameViewModel>.self)
    }

    @ViewBuilder
    func currentScreen() -> some View {
        if let last = paths.last {
            switch last {
            case .overview:
                container.resolve(type: GameOverviewScreen<GameOverviewViewModel>.self)
            }
        } else {
            fatalError("This shouldn't happen")
        }
    }
}
