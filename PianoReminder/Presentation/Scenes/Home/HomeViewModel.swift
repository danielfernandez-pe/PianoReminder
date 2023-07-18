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

    private let setupGameSessionUseCase: any SetupGameSessionUseCaseType
    private weak var homeRouter: (any HomeRouter)? // TODO weak not letting to work the router

    init(setupGameSessionUseCase: any SetupGameSessionUseCaseType, homeRouter: any HomeRouter) {
        self.setupGameSessionUseCase = setupGameSessionUseCase
        self.homeRouter = homeRouter
    }

    @MainActor
    func setupGame() async {
        do {
            try await setupGameSessionUseCase.setupGameSession()
            homeRouter?.openGame()
//            router.presentGame()
        } catch {
            uiError = .gameStart
        }
    }

    @MainActor
    private func setError(to error: UIError) {
        uiError = error
    }
}
