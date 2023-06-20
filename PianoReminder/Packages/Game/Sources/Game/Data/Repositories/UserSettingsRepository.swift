//
//  UserSettingsRepository.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

public final class UserSettingsRepository<Service: UserServiceType>: UserSettingsRepositoryType {
    private let userService: Service

    public init(userService: Service) {
        self.userService = userService
    }

    public func getGameType() -> GameType {
        userService.getGameType()
    }
}
