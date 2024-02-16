//
//  GetGameTypeUseCase.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation

struct GetGameTypeUseCase {
    private let userSettingsRepository: any UserSettingsRepositoryType

    init(userSettingsRepository: any UserSettingsRepositoryType) {
        self.userSettingsRepository = userSettingsRepository
    }

    func getGameType() -> GameType {
        userSettingsRepository.getGameType()
    }
}
