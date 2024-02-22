//
//  GetQuestionUseCase.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

final class GetQuestionUseCase {
    private let userSettingsRepository: any UserSettingsRepositoryType
    private let gameRepository: any GameRepositoryType

    init(userSettingsRepository: any UserSettingsRepositoryType,
         gameRepository: any GameRepositoryType) {
        self.userSettingsRepository = userSettingsRepository
        self.gameRepository = gameRepository
    }

    func getQuestion() async -> QuestionDOM {
        let settings = userSettingsRepository.getGameSettings()
        // get note, chords or questions

        let chord = await gameRepository.getChords()[0]
//        let chordQuestion = ChordQuestionDOM(question: chord, chordOptions: [])

        return QuestionDOM(
            options: [
                UserOptionDOM(title: "No1", isAnswer: false),
                UserOptionDOM(title: "No2", isAnswer: false),
                UserOptionDOM(title: "Yes", isAnswer: true),
                UserOptionDOM(title: "No3", isAnswer: false)
            ],
            questionType: .chord(chord),
            category: .sightReading
        )
    }
}
// TODO: Do we need ChordQuestionDOM ? 
