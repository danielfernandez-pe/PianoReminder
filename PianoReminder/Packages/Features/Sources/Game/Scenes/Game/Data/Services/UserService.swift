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
            isHistoryQuestionsEnabled: true,
            isChordsEnabled: false,
            isNotesEnabled: true,
            isListeningEnabled: false,
            isSoundsEnabled: true
        )
    }
}
