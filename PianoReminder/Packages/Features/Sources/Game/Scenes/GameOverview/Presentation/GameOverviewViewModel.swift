//
//  GameOverviewViewModel.swift
//  
//
//  Created by Daniel Yopla on 25.06.2023.
//

import Combine

protocol GameOverviewViewModelInputs {
    func backHomeTap()
}

protocol GameOverviewViewModelOutputs {
}

protocol GameOverviewViewModelType: GameOverviewViewModelInputs, GameOverviewViewModelOutputs {}

final class GameOverviewViewModel: GameOverviewViewModelType {
    enum Route {
        case close
    }

    let routing = PassthroughSubject<Route, Never>()

    // MARK: - Dependencies

    private let correctQuestions: [QuestionDOM]

    init(correctQuestions: [QuestionDOM]) {
        self.correctQuestions = correctQuestions
        print(correctQuestions)
    }

    func backHomeTap() {
        routing.send(.close)
    }
}
