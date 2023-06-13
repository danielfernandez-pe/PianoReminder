//
//  GameRepository.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

public protocol GameRepositoryType: ObservableObject {
    var points: Int { get }

    func setupGameSession() async throws
    func getQuestion(gameType: GameType) -> Question
    func increasePoints()
}

public final class GameRepository<Service: GameServiceType>: GameRepositoryType {
    @Published public var points = 0

    private var quizNotes: [SingleNote] = []
    private var quizChords: [Chord] = []

    private var usedNotes: [SingleNote] = []
    private var usedChords: [Chord] = []

    private let gameService: Service

    public init(gameService: Service) {
        self.gameService = gameService
    }

    public func setupGameSession() async throws {
        usedChords.removeAll()
        quizNotes = try await gameService.fetchNotes()
        quizChords = try await gameService.fetchChords()
    }

    public func getQuestion(gameType: GameType) -> Question {
        switch gameType {
        case .notes:
            return getNoteQuestion().getQuestion()
        case .chords:
            return getChordQuestion().getQuestion()
        case .notesAndChords:
            fatalError("Not implemented yet")
        }
    }

    private func getChordQuestion() -> ChordQuestion {
        let answerChord = getChord()
        var optionsIndices: Set<Chord> = [answerChord]

        let totalOptions = quizChords + usedChords
        while optionsIndices.count < 4 {
            let randomIndex = Int.random(in: 0..<totalOptions.count)
            optionsIndices.insert(totalOptions[randomIndex])
        }

        var options: [ChordQuestion.Option] = optionsIndices.map {
            ChordQuestion.Option(value: $0, isAnswer: answerChord == $0)
        }

        options.shuffle()
        return ChordQuestion(question: answerChord, chordOptions: options)
    }

    private func getNoteQuestion() -> NoteQuestion {
        let answerNote = getNote()
        var optionsIndices: Set<SingleNote> = [answerNote]

        let totalOptions = quizNotes + usedNotes
        while optionsIndices.count < 4 {
            let randomIndex = Int.random(in: 0..<totalOptions.count)
            optionsIndices.insert(totalOptions[randomIndex])
        }

        var options: [NoteQuestion.Option] = optionsIndices.map {
            NoteQuestion.Option(value: $0, isAnswer: answerNote == $0)
        }

        options.shuffle()
        return NoteQuestion(question: answerNote, noteOptions: options)
    }

    public func increasePoints() {
        points += 1
    }

    private func getNote() -> SingleNote {
        if quizNotes.isEmpty {
            quizNotes = usedNotes
            usedNotes.removeAll()
        }

        let notesCount = quizNotes.count

        guard notesCount > 1 else {
            let noteToUse = quizNotes.removeLast()
            usedNotes.append(noteToUse)
            return noteToUse
        }

        let randomIndex = Int.random(in: 0..<notesCount)
        let noteToUse = quizNotes.remove(at: randomIndex)
        usedNotes.append(noteToUse)
        return noteToUse
    }

    private func getChord() -> Chord {
        if quizChords.isEmpty {
            quizChords = usedChords
            usedChords.removeAll()
        }

        let chordsCount = quizChords.count

        guard chordsCount > 1 else {
            let chordToUse = quizChords.removeLast()
            usedChords.append(chordToUse)
            return chordToUse
        }

        let randomIndex = Int.random(in: 0..<chordsCount)
        let chordToUse = quizChords.remove(at: randomIndex)
        usedChords.append(chordToUse)
        return chordToUse
    }
}
