//
//  GameRepository.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

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
//            let storyQuestions = try await gameService.fetchStoryQuestions()
            
            let chordQuestions = chords.compactMap { QuestionDAO(chord: $0, note: nil, story: nil, isChordQuestion: true, isNoteQuestion: false, isStoryQuestion: false) }
            let noteQuestions = notes.compactMap { QuestionDAO(chord: nil, note: $0, story: nil, isChordQuestion: false, isNoteQuestion: true, isStoryQuestion: false) }
            
            // Uncomment when is a fresh install
//            await gameStorage.save(data: chordQuestions)
//            await gameStorage.save(data: noteQuestions)
//            await gameStorage.save(data: storyQuestions)
        } catch {
            // log, try again in next session
        }
    }

    func getQuestions() async -> [QuestionDOM] {
        let questions = await gameStorage.fetchQuestions()
        return questions.compactMap { DataMapper.question($0) }
    }
}
