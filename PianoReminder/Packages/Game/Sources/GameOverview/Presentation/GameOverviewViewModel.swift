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

protocol GameOverviewViewModelOutputs: ObservableObject {
}

protocol GameOverviewViewModelType: GameOverviewViewModelInputs, GameOverviewViewModelOutputs {}

final class GameOverviewViewModel: GameOverviewViewModelType {
    // MARK: - Dependencies

    private let router: GameRouter

    init(router: GameRouter) {
        self.router = router
    }

    func backHomeTap() {
        router.finish()
    }
}
