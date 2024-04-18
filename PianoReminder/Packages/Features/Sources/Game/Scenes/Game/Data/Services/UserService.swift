//
//  UserService.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Foundation

final class UserService {
    func getGameSettings() -> GameSettingsDOM {
        .init(
            isStoryQuestionsEnabled: true,
            isChordsEnabled: false,
            isNotesEnabled: false,
            isListeningEnabled: false,
            isSoundsEnabled: true
        )
    }
}
