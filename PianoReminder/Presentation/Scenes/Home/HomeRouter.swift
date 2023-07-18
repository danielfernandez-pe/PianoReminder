////
////  HomeRouter.swift
////  PianoReminder
////
////  Created by Daniel Yopla on 19.05.2023.
////
//
//import SwiftUI
//import Combine
//import Core
//import Game
//import DependencyInjection
//
//public final class HomeRouter: BaseRouter<HomeRouter.Path>, Routing {
//    public enum Path {
//        case something
//    }
//
//    public var didFinish: AnyPublisher<Void, Never> { didFinishSubject.eraseToAnyPublisher() }
//
//    @Published var isGamePresented = false
//
//    // MARK: - Private properties
//
//    private let didFinishSubject = PassthroughSubject<Void, Never>()
//    private var cancellable: AnyCancellable?
//
//    // MARK: - Dependencies
//
//    private let container: any DICProtocol
////    private let gameRouter: GameRouter
//
//    public init(container: any DICProtocol) {
//        self.container = container
////        gameRouter = container.resolveService(GameRouter.self)
//    }
//
//    public func start() -> some View {
////        container.resolve(type: GameScreen<GameViewModel>.self) example
//        EmptyView()
//    }
//
//    func presentGame() {
//        isGamePresented = true
//
////        cancellable = gameRouter
////            .didFinish
////            .sink { [weak self] _ in
////                self?.isGamePresented = false
////            }
//    }
//
//    func startGame() -> some View {
//        EmptyView()
////        gameRouter.start()
//    }
//
//    @ViewBuilder
//    func currentScreen() -> some View {
//        if let last = paths.last {
//            switch last {
//            case .something:
////                container.resolve(type: GameOverviewScreen<GameOverviewViewModel>.self) example
//                EmptyView()
//            }
//        } else {
//            fatalError("This shouldn't happen")
//        }
//    }
//}
