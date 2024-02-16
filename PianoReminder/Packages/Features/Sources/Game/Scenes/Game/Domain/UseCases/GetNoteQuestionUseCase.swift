//
//  GetNoteQuestionUseCase.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

struct GetNoteQuestionUseCase {
    private let gameRepository: any GameRepositoryType

    init(gameRepository: any GameRepositoryType) {
        self.gameRepository = gameRepository
    }

    func getNoteQuestion() -> NoteQuestion {
        let answerNote = gameRepository.getNote()
        var optionsIndices: Set<SingleNote> = [answerNote]

        let totalOptions = gameRepository.noteOptions()

        while optionsIndices.count < 4 {
            let randomIndex = Int.random(in: 0..<totalOptions.count)
            let possibleOption = totalOptions[randomIndex]

            if !optionsIndices.contains(where: { $0.title == possibleOption.title }) {
                optionsIndices.insert(possibleOption)
            }
        }

        var options: [NoteQuestion.Option] = optionsIndices.map {
            NoteQuestion.Option(value: $0, isAnswer: answerNote == $0)
        }

        options.shuffle()
        return NoteQuestion(question: answerNote, noteOptions: options)
    }
}
