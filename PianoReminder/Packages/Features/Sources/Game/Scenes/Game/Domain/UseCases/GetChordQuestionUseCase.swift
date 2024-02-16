//
//  GetChordQuestionUseCase.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation

struct GetChordQuestionUseCase {
    private let gameRepository: any GameRepositoryType

    init(gameRepository: any GameRepositoryType) {
        self.gameRepository = gameRepository
    }

    func getChordQuestion() -> ChordQuestion {
        let answerChord = gameRepository.getChord()
        var optionsIndices: Set<Chord> = [answerChord]

        let totalOptions = gameRepository.chordOptions()
        while optionsIndices.count < 4 {
            let randomIndex = Int.random(in: 0..<totalOptions.count)
            let possibleOption = totalOptions[randomIndex]

            if !optionsIndices.contains(where: { $0.title == possibleOption.title }) {
                optionsIndices.insert(possibleOption)
            }
        }

        var options: [ChordQuestion.Option] = optionsIndices.map {
            ChordQuestion.Option(value: $0, isAnswer: answerChord == $0)
        }

        options.shuffle()
        return ChordQuestion(question: answerChord, chordOptions: options)
    }
}
