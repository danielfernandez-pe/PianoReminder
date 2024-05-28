//
//  GameRepository.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation
import CompoundPredicate

final class GameRepository: GameRepositoryType {
    private let gameService: GameService
    private let gameStorage: GameStorage

    init(gameService: GameService, gameStorage: GameStorage) {
        self.gameService = gameService
        self.gameStorage = gameStorage
    }

    func sync() async {
        do {
            // mechanism to know how to sync only new ones or update old ones? Using Date of update or something
            let chords = try await gameService.fetchChords()
            let notes = try await gameService.fetchNotes()
            let history = try await gameService.fetchHistoryQuestions()
            
            logger.debug("Getting new \(chords.count) chords, \(notes.count) notes and \(history.count) history questions")
            
            let chordQuestions = chords.compactMap { QuestionDAO(chord: $0, note: nil, history: nil, isChordQuestion: true, isNoteQuestion: false, isHistoryQuestion: false) }
            let noteQuestions = notes.compactMap { QuestionDAO(chord: nil, note: $0, history: nil, isChordQuestion: false, isNoteQuestion: true, isHistoryQuestion: false) }
            let historyQuestions = history.compactMap { QuestionDAO(chord: nil, note: nil, history: $0, isChordQuestion: false, isNoteQuestion: false, isHistoryQuestion: true) }
            
            // Uncomment when is a fresh install
//            await gameStorage.save(data: chordQuestions)
//            await gameStorage.save(data: noteQuestions)
//            await gameStorage.save(data: historyQuestions)
        } catch {
            logger.error("Sync failing \(error)")
        }
    }

    func getQuestions(includeChords: Bool,
                      includeNotes: Bool,
                      includeStories: Bool,
                      limit: Int?) async -> [QuestionDOM] {
        let chordPredicate = #Predicate<QuestionDAO> { question in
            includeChords ? question.isChordQuestion == true : false
        }

        let notePredicate = #Predicate<QuestionDAO> { question in
            includeNotes ? question.isNoteQuestion == true : false
        }

        let storyPredicate = #Predicate<QuestionDAO> { question in
            includeStories ? question.isHistoryQuestion == true : false
        }

        let finalPredicate = [chordPredicate, notePredicate, storyPredicate].disjunction()
        let questions = await gameStorage.fetchQuestions(predicate: finalPredicate, limit: limit)
        return questions.compactMap { DataMapper.question($0) }
    }
}
