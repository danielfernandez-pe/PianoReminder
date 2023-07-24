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

protocol GameOverviewRouter: AnyObject {
    func closeGame()
}

final class GameOverviewViewModel: GameOverviewViewModelType {
    weak var router: (any GameOverviewRouter)?

    // MARK: - Dependencies

    func backHomeTap() {
        router?.closeGame()
    }
}
