//
//  GameEngine.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

public actor GameManager<Service: GameServiceType>: ObservableObject {
    @Published var counter = 60
    @Published var points = 0

    private var quizNotes: [SingleNote] = []
    private var quizChords: [ChordNote] = []

    private let gameService: Service

    public init(gameService: Service) {
        self.gameService = gameService
    }

    public func setupGameSession() async throws {
        // TODO: do real networking fetch
        quizNotes = try await gameService.fetchNotes()
        quizChords = try await gameService.fetchChords()
    }

    func getNote() -> SingleNote? {
        guard !quizNotes.isEmpty else { return nil }

        let notesCount = quizNotes.count

        guard notesCount > 1 else { return quizNotes.removeLast() }

        let randomIndex = Int.random(in: 0..<notesCount)
        return quizNotes.remove(at: randomIndex)
    }

    func getChord() -> ChordNote? {
        guard !quizChords.isEmpty else { return nil }

        let chordsCount = quizChords.count

        guard chordsCount > 1 else { return quizChords.removeLast() }

        let randomIndex = Int.random(in: 0..<chordsCount)
        return quizChords.remove(at: randomIndex)
    }
}
