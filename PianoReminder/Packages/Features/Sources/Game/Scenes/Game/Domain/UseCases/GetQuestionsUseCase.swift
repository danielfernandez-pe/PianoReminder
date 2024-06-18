//
//  GetQuestionsUseCase.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

protocol GetQuestionsUseCaseType {
    func getQuestions(isNewSession: Bool) async -> [QuestionDOM]
}

struct GetQuestionsUseCase: GetQuestionsUseCaseType {
    private let getGameSettingsUseCase: any GetGameSettingsUseCaseType
    private let gameRepository: any GameRepositoryType

    init(getGameSettingsUseCase: any GetGameSettingsUseCaseType,
         gameRepository: any GameRepositoryType) {
        self.getGameSettingsUseCase = getGameSettingsUseCase
        self.gameRepository = gameRepository
    }

    func getQuestions(isNewSession: Bool) async -> [QuestionDOM] {
        let settings = getGameSettingsUseCase.getGameSettings()
        let fetchedQuestions = await gameRepository.getQuestions(
            includeChords: settings.isChordsEnabled,
            includeNotes: settings.isNotesEnabled,
            includeHistory: isNewSession ? settings.isHistoryQuestionsEnabled : false,
            limit: nil
        ).shuffled()
        return fetchedQuestions
    }
}
