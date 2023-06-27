//
//  UserSettingsRepository.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Combine

protocol UserSettingsRepositoryType: ObservableObject {
    func getGameType() -> GameType
}