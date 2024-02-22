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
            // mechanism to know how to sync only new ones or update old ones?
            let chords = try await gameService.fetchChords()
            let notes = try await gameService.fetchNotes()
//            let storyQuestions = try await gameService.fetchStoryQuestions()
            await gameStorage.save(data: chords)
            await gameStorage.save(data: notes)
//            await gameStorage.save(data: storyQuestions)
        } catch {
            // log, try again in next session
        }
    }

    func getNotes() async -> [SingleNoteDOM] {
        let notes = await gameStorage.fetchNotes()
        let notesDOM = notes.compactMap { DataMapper.singleNote($0) }
        return notesDOM
    }

    func getChords() async -> [ChordDOM] {
        let chords = await gameStorage.fetchChords()
        let chordsDOM = chords.compactMap { DataMapper.chord($0) }
        return chordsDOM
    }

    func getStoryQuestions() async -> [StoryDOM] {
        []
    }
}
