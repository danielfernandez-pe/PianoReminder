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

    private weak var homeRouter: (any HomeRouter)? // TODO: weak not letting to work the router

    init(homeRouter: any HomeRouter) {
        self.homeRouter = homeRouter
    }

    func setupGame() {
        homeRouter?.openGame()
    }

    @MainActor
    private func setError(to error: UIError) {
        uiError = error
    }
}
