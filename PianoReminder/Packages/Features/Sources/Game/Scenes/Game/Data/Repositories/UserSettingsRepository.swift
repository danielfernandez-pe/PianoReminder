//
//  UserSettingsRepository.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

final class UserSettingsRepository<Service: UserServiceType>: UserSettingsRepositoryType {
    private let userService: Service

    init(userService: Service) {
        self.userService = userService
    }

    func getGameType() -> GameType {
        userService.getGameType()
    }
}
