//
//  GameRouter.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Combine
import SwiftUI
import Core
import DependencyInjection

public final class GameRouter: BaseRouter<GameRouter.Path>, Routing {
    public enum Path {
        case overview
    }

    public var didFinish: AnyPublisher<Void, Never> { didFinishSubject.eraseToAnyPublisher() }

    // MARK: - Private properties

    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Dependencies

    private let container: any DICProtocol

    public init(container: any DICProtocol) {
        self.container = container
    }

    public func start() -> some View {
        container.resolveService(GameScreen<GameViewModel>.self)
    }

    func finish() {
        didFinishSubject.sendAndComplete() // TODO: this should be fix by a new DI library
    }

    @ViewBuilder
    func currentScreen() -> some View {
        if let last = paths.last {
            switch last {
            case .overview:
                container.resolveService(GameOverviewScreen<GameOverviewViewModel>.self)
            }
        } else {
            fatalError("This shouldn't happen")
        }
    }
}

extension PassthroughSubject where Output == Void {
    func sendAndComplete() {
        self.send()
        self.send(completion: .finished)
    }
}
