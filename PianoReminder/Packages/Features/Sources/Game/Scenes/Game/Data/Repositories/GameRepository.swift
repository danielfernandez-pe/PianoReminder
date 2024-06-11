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

    func sync(lastSynced: Date?) async throws {
        // did I sync before?
        // if yes: I create a query for the snapshot and in the background will get the list of syncs, then one by one I'll make a new query to save in db
        // if not: I sync all
        // If the user starts a game while I don't have anything on db (I'm probably syncing and we can just check lastSynced is not null) then I'll use the memory chords
        if let lastSynced {
            logger.debug("Starting incremental sync from \(lastSynced)")
            let entitiesToSync = try await gameService.fetchEntitiesToSync(from: lastSynced)
            for entityToSync in entitiesToSync {
                print(entityToSync.id)
            }
        } else {
            try await syncAll()
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
    
    private func syncAll() async throws {
        logger.debug("Starting full sync")

        let chords = try await gameService.fetchChords()
        let notes = try await gameService.fetchNotes()
        let history = try await gameService.fetchHistoryQuestions()
        
        logger.debug("Getting new \(chords.count) chords, \(notes.count) notes and \(history.count) history questions")
        
        let chordQuestions = chords.compactMap { QuestionDAO(chord: $0, note: nil, history: nil, isChordQuestion: true, isNoteQuestion: false, isHistoryQuestion: false) }
        let noteQuestions = notes.compactMap { QuestionDAO(chord: nil, note: $0, history: nil, isChordQuestion: false, isNoteQuestion: true, isHistoryQuestion: false) }
        let historyQuestions = history.compactMap { QuestionDAO(chord: nil, note: nil, history: $0, isChordQuestion: false, isNoteQuestion: false, isHistoryQuestion: true) }

        await gameStorage.save(data: chordQuestions)
        await gameStorage.save(data: noteQuestions)
        await gameStorage.save(data: historyQuestions)
    }
}
