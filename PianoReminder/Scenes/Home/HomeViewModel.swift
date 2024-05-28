// 
//  HomeViewModel.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import SwiftUI
import GameAPI
import Networking

protocol HomeViewModelInputs {
    func setupGame() async
}

protocol HomeViewModelOutputs {
    var uiError: HomeViewModel.UIError? { get }
}

protocol HomeRouter: AnyObject {
    func openGame()
}

protocol HomeViewModelType: HomeViewModelInputs, HomeViewModelOutputs {}

@Observable final class HomeViewModel: HomeViewModelType {
    enum UIError: Error {
        case gameStart
    }

    var uiError: UIError?

    private let syncGameUseCase: any SyncGameDataUseCaseType
    private weak var homeRouter: (any HomeRouter)? // TODO: weak not letting to work the router

    init(syncGameUseCase: any SyncGameDataUseCaseType, homeRouter: any HomeRouter) {
        self.syncGameUseCase = syncGameUseCase
        self.homeRouter = homeRouter

        Task {
            await syncGameUseCase.sync()
        }
    }

    @MainActor
    func setupGame() async {
        await syncGameUseCase.sync() // TODO: this shouldn't be a limit to start game, I should do it in the background all the time
        homeRouter?.openGame()
    }

    @MainActor
    private func setError(to error: UIError) {
        uiError = error
    }
}
