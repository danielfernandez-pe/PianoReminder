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
    func getChordQuestion() -> ChordQuestion
    func getNoteQuestion() -> NoteQuestion
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
        quizNotes = try await gameService.fetchNotes()
        quizChords = try await gameService.fetchChords()
    }

    public func getChordQuestion() -> ChordQuestion {
        let answerChord = getChord(needToRemove: true)
        var options: [ChordQuestion.Option] = Array(1...3).map { _ in ChordQuestion.Option(value: getChord(needToRemove: false), isAnswer: false) }
        options.append(.init(value: answerChord, isAnswer: true))
        options.shuffle()
        return ChordQuestion(question: answerChord, options: options)
    }

    public func getNoteQuestion() -> NoteQuestion {
        let answerNote = getNote(needToRemove: true)
        var options: [NoteQuestion.Option] = Array(1...3).map { _ in NoteQuestion.Option(value: getNote(needToRemove: false), isAnswer: false) }
        options.append(.init(value: answerNote, isAnswer: true))
        options.shuffle()
        return NoteQuestion(question: answerNote, options: options)
    }

    public func increasePoints() {
        points += 1
    }

    private func getNote(needToRemove: Bool) -> SingleNote {
        if quizNotes.isEmpty {
            quizNotes = usedNotes
            usedNotes.removeAll()
        }

        let notesCount = quizNotes.count

        guard notesCount > 1 else {
            if needToRemove {
                let noteToUse = quizNotes.removeLast()
                usedNotes.append(noteToUse)
                return noteToUse
            } else {
                return quizNotes.first!
            }
        }

        let randomIndex = Int.random(in: 0..<notesCount)

        if needToRemove {
            let noteToUse = quizNotes.remove(at: randomIndex)
            usedNotes.append(noteToUse)
            return noteToUse
        } else {
            return quizNotes[randomIndex]
        }
    }

    private func getChord(needToRemove: Bool) -> Chord {
        if quizChords.isEmpty {
            quizChords = usedChords
            usedChords.removeAll()
        }

        let chordsCount = quizChords.count

        guard chordsCount > 1 else {
            if needToRemove {
                let chordToUse = quizChords.removeLast()
                usedChords.append(chordToUse)
                return chordToUse
            } else {
                return quizChords.first!
            }
        }

        let randomIndex = Int.random(in: 0..<chordsCount)

        if needToRemove {
            let chordToUse = quizChords.remove(at: randomIndex)
            usedChords.append(chordToUse)
            return chordToUse
        } else {
            return quizChords[randomIndex]
        }
    }
}
