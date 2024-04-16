//
//  GetGameTypeUseCase.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation

protocol GetGameSettingsUseCaseType {
    func getGameSettings() -> GameSettingsDOM
}

struct GetGameSettingsUseCase: GetGameSettingsUseCaseType {
    private let userSettingsRepository: any UserSettingsRepositoryType

    init(userSettingsRepository: any UserSettingsRepositoryType) {
        self.userSettingsRepository = userSettingsRepository
    }

    func getGameSettings() -> GameSettingsDOM {
        userSettingsRepository.getGameSettings()
    }
}
