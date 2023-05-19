// 
//  HomeViewModel.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import Game

protocol HomeViewModelInputs {
    func setupGame() async
}

protocol HomeViewModelOutputs: ObservableObject {
    var uiError: HomeViewModel.UIError? { get }
}

protocol HomeViewModelType: HomeViewModelInputs, HomeViewModelOutputs {}

final class HomeViewModel: HomeViewModelType {
    enum UIError: Error {
        case gameStart
    }

    @Published var uiError: UIError?

    private let gameManager: GameManager<GameService>

    init(gameManager: GameManager<GameService>) {
        self.gameManager = gameManager
    }

    func setupGame() async {
        do {
            try await gameManager.setupGameSession()
            //figure out routing to other modules in swiftui app
        } catch {
            uiError = .gameStart
        }
    }

    @MainActor
    private func setError(to error: UIError) {
        uiError = error
    }
}
