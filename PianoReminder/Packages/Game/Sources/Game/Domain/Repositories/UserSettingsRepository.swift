//
//  UserSettingsRepository.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Combine

public protocol UserSettingsRepositoryType: ObservableObject {
    func getGameType() -> GameType
}

public final class UserSettingsRepository<Service: UserServiceType>: UserSettingsRepositoryType {
    private let userService: Service

    public init(userService: Service) {
        self.userService = userService
    }

    public func getGameType() -> GameType {
        userService.getGameType()
    }
}
