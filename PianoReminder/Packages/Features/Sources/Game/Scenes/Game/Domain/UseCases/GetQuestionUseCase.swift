//
//  GetQuestionUseCase.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

final class GetQuestionsUseCase {
    private let userSettingsRepository: any UserSettingsRepositoryType
    private let gameRepository: any GameRepositoryType

    init(userSettingsRepository: any UserSettingsRepositoryType,
         gameRepository: any GameRepositoryType) {
        self.userSettingsRepository = userSettingsRepository
        self.gameRepository = gameRepository
    }

    func getQuestions() async -> [QuestionDOM] {
        let settings = userSettingsRepository.getGameSettings()
        // get note, chords or questions
        // check isUsed and get 20 questions
        let fetchedQuestions = await gameRepository.getQuestions().shuffled()
        
        // if the fetchedQuestions are less than 20, start calling again without isUsed?
        return fetchedQuestions
    }
}
