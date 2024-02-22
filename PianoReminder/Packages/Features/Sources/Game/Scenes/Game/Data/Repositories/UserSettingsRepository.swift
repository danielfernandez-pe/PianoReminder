//
//  UserSettingsRepository.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

final class UserSettingsRepository: UserSettingsRepositoryType {
    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func getGameSettings() -> GameSettingsDOM {
        userService.getGameSettings()
    }
}
