// 
//  HomeViewModel.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import Game

protocol HomeViewModelInputs {
    func setupGame()
}

protocol HomeViewModelOutputs: ObservableObject {
    var homeError: HomeViewModel.HomeError? { get }
}

protocol HomeViewModelType: HomeViewModelInputs, HomeViewModelOutputs {}

// @MainActor ??
final class HomeViewModel: HomeViewModelType {
    enum HomeError: Error {
        case game
    }

    @Published var homeError: HomeError?

    private let gameManager: GameManager<GameService>

    init(gameManager: GameManager<GameService>) {
        self.gameManager = gameManager
    }

    func setupGame() {
        Task {
            do {
                try await gameManager.setupGameSession()
            } catch {
                homeError = .game
            }
        }
    }
}
