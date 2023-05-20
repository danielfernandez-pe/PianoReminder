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

    private let gameRepository: any GameRepositoryType
    private let router: HomeRouter

    init(gameRepository: any GameRepositoryType, router: HomeRouter) {
        self.gameRepository = gameRepository
        self.router = router
    }

    @MainActor
    func setupGame() async {
        do {
            try await gameRepository.setupGameSession()
            router.push(.game)
        } catch {
            uiError = .gameStart
        }
    }

    @MainActor
    private func setError(to error: UIError) {
        uiError = error
    }
}
