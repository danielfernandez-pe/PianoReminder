// 
//  HomeViewModel.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import SwiftUI
import GameAPI

protocol HomeViewModelInputs {
    func setupGame() async
}

protocol HomeViewModelOutputs: ObservableObject {
    associatedtype Content: View

    var uiError: HomeViewModel.UIError? { get }

    func gameStartScreen() -> Content
}

protocol HomeViewModelType: HomeViewModelInputs, HomeViewModelOutputs {}

final class HomeViewModel: HomeViewModelType {
    enum UIError: Error {
        case gameStart
    }

    @Published var uiError: UIError?

    private let setupGameSessionUseCase: any SetupGameSessionUseCaseType
    private let router: HomeRouter

    init(setupGameSessionUseCase: any SetupGameSessionUseCaseType, router: HomeRouter) {
        self.setupGameSessionUseCase = setupGameSessionUseCase
        self.router = router
    }

    @MainActor
    func setupGame() async {
        do {
            try await setupGameSessionUseCase.setupGameSession()
        } catch {
            uiError = .gameStart
        }
    }

    func gameStartScreen() -> some View {
        router.startGame()
    }

    @MainActor
    private func setError(to error: UIError) {
        uiError = error
    }
}
