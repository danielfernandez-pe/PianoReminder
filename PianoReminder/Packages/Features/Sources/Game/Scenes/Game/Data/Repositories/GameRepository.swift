//
//  GameRepository.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

final class GameRepository<Service: GameServiceType>: GameRepositoryType {
    private var quizNotes: [SingleNoteDTO] = []
    private var quizChords: [ChordDTO] = []

    private var usedNotes: [SingleNoteDTO] = []
    private var usedChords: [ChordDTO] = []

    private let gameService: Service

    init(gameService: Service) {
        self.gameService = gameService
    }

    func setupGameSession() async throws {
        usedChords.removeAll()
        usedNotes.removeAll()
        quizNotes = try await gameService.fetchNotes()
        quizChords = try await gameService.fetchChords()
    }

    func noteOptions() -> [SingleNote] {
        quizNotes.map { $0.toModel() } + usedNotes.map { $0.toModel() }
    }

    func chordOptions() -> [Chord] {
        quizChords.map { $0.toModel() } + usedChords.map { $0.toModel() }
    }

    func getNote() -> SingleNote {
        if quizNotes.isEmpty {
            quizNotes = usedNotes
            usedNotes.removeAll()
        }

        let notesCount = quizNotes.count

        guard notesCount > 1 else {
            let noteToUse = quizNotes.removeLast()
            usedNotes.append(noteToUse)
            return noteToUse.toModel()
        }

        let randomIndex = Int.random(in: 0..<notesCount)
        let noteToUse = quizNotes.remove(at: randomIndex)
        usedNotes.append(noteToUse)
        return noteToUse.toModel()
    }

    func getChord() -> Chord {
        if quizChords.isEmpty {
            quizChords = usedChords
            usedChords.removeAll()
        }

        let chordsCount = quizChords.count

        guard chordsCount > 1 else {
            let chordToUse = quizChords.removeLast()
            usedChords.append(chordToUse)
            return chordToUse.toModel()
        }

        let randomIndex = Int.random(in: 0..<chordsCount)
        let chordToUse = quizChords.remove(at: randomIndex)
        usedChords.append(chordToUse)
        return chordToUse.toModel()
    }
}
