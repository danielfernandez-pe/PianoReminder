//
//  GameOverviewViewModel.swift
//  
//
//  Created by Daniel Yopla on 25.06.2023.
//

import Combine

protocol GameOverviewViewModelInputs {
}

protocol GameOverviewViewModelOutputs: ObservableObject {
}

protocol GameOverviewViewModelType: GameOverviewViewModelInputs, GameOverviewViewModelOutputs {}

final class GameOverviewViewModel: GameOverviewViewModelType {
    // MARK: - Dependencies

    // MARK: - Properties

    init() {
    }
}
