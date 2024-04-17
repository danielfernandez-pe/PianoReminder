//
//  GetQuestionsUseCase.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

protocol GetQuestionsUseCaseType {
    func getQuestions() async -> [QuestionDOM]
}

struct GetQuestionsUseCase: GetQuestionsUseCaseType {
    private let getGameSettingsUseCase: any GetGameSettingsUseCaseType
    private let gameRepository: any GameRepositoryType

    init(getGameSettingsUseCase: any GetGameSettingsUseCaseType,
         gameRepository: any GameRepositoryType) {
        self.getGameSettingsUseCase = getGameSettingsUseCase
        self.gameRepository = gameRepository
    }

    func getQuestions() async -> [QuestionDOM] {
        let settings = getGameSettingsUseCase.getGameSettings()
        // get note, chords or questions

        let fetchedQuestions = await gameRepository.getQuestions().shuffled()
        return fetchedQuestions
    }
}
