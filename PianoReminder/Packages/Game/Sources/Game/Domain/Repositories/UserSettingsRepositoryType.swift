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
