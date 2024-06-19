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

    func sync(lastSynced: String?) async throws {
        if let lastSynced {
            logger.debug("Starting incremental sync from \(lastSynced)")
            let entitiesToSync = try await gameService.fetchEntitiesToSync(from: lastSynced)
            for entityToSync in entitiesToSync {
                switch entityToSync.path {
                case .chords:
                    try await syncChord(entity: entityToSync)
                case .notes:
                    try await syncNote(entity: entityToSync)
                case .history:
                    try await syncHistory(entity: entityToSync)
                default:
                    break
                }
            }
        } else {
            try await syncAll()
        }
    }

    private func syncChord(entity: EntityToSyncDTO) async throws {
        switch entity.syncType {
        case .created:
            logger.debug("Sync - starting creating of entity for chord")
            let unsyncedChord = try await gameService.fetchChord(id: entity.entityId)
            await gameStorage.save(data: [unsyncedChord])
        case .updated:
            logger.debug("Sync - starting updating of entity for chord")
            let unsyncedChord = try await gameService.fetchChord(id: entity.entityId)
            let entityId = entity.entityId
            let predicate = #Predicate<ChordDAO> { chord in
                chord.id == entityId
            }

            await gameStorage.updateEntity(predicate: predicate) { chord in
                chord.title = unsyncedChord.title
                chord.clef = unsyncedChord.clef
                chord.notes = unsyncedChord.notes
            }
        case .deleted:
            logger.debug("Sync - starting deletion of entity for chord")
            let entityId = entity.entityId
            let predicate = #Predicate<ChordDAO> { chord in
                chord.id == entityId
            }

            await gameStorage.deleteEntity(predicate: predicate)
        }
    }

    private func syncNote(entity: EntityToSyncDTO) async throws {
        switch entity.syncType {
        case .created:
            logger.debug("Sync - starting creating of entity for note")
            let unsyncNote = try await gameService.fetchNote(id: entity.entityId)
            await gameStorage.save(data: [unsyncNote])
        case .updated:
            logger.debug("Sync - starting updating of entity for note")
            let unsyncedNote = try await gameService.fetchNote(id: entity.entityId)
            let entityId = entity.entityId
            let predicate = #Predicate<SingleNoteDAO> { note in
                note.id == entityId
            }

            await gameStorage.updateEntity(predicate: predicate) { note in
                note.title = unsyncedNote.title
                note.clef = unsyncedNote.clef
                note.value = unsyncedNote.value
            }
        case .deleted:
            logger.debug("Sync - starting deletion of entity for note")
            let entityId = entity.entityId
            let predicate = #Predicate<SingleNoteDAO> { note in
                note.id == entityId
            }

            await gameStorage.deleteEntity(predicate: predicate)
        }
    }

    private func syncHistory(entity: EntityToSyncDTO) async throws {
        switch entity.syncType {
        case .created:
            logger.debug("Sync - starting creating of entity for history")
            let unsyncedHistory = try await gameService.fetchHistory(id: entity.entityId)
            await gameStorage.save(data: [unsyncedHistory])
        case .updated:
            logger.debug("Sync - starting updating of entity for history")
            let unsyncedHistory = try await gameService.fetchHistory(id: entity.entityId)
            let entityId = entity.entityId
            let predicate = #Predicate<HistoryDAO> { history in
                history.id == entityId
            }

            await gameStorage.updateEntity(predicate: predicate) { history in
                history.titleQuestion = unsyncedHistory.titleQuestion
                history.historyOptions = unsyncedHistory.historyOptions
            }
        case .deleted:
            logger.debug("Sync - starting deletion of entity for history")
            let entityId = entity.entityId
            let predicate = #Predicate<HistoryDAO> { history in
                history.id == entityId
            }

            await gameStorage.deleteEntity(predicate: predicate)
        }
    }

    func getQuestions(includeChords: Bool,
                      includeNotes: Bool,
                      includeHistory: Bool,
                      limit: Int?) async -> [QuestionDOM] {
        var questions: [QuestionDOM] = []

        if includeChords {
            let predicate = #Predicate<ChordDAO> { _ in true }
            let chords = await gameStorage.fetchEntities(predicate: predicate)
            questions.append(contentsOf: chords.map { DataMapper.question(fromChord: $0) })
        }

        if includeNotes {
            let predicate = #Predicate<SingleNoteDAO> { _ in true }
            let notes = await gameStorage.fetchEntities(predicate: predicate)
            questions.append(contentsOf: notes.map { DataMapper.question(fromNote: $0) })
        }

        if includeHistory {
            let predicate = #Predicate<HistoryDAO> { _ in true }
            let history = await gameStorage.fetchEntities(predicate: predicate)
            questions.append(contentsOf: history.map { DataMapper.question(fromHistory: $0) })
        }

        return questions
    }
    
    private func syncAll() async throws {
        logger.debug("Starting full sync")

        let chords = try await gameService.fetchChords()
        let notes = try await gameService.fetchNotes()
        let history = try await gameService.fetchHistoryQuestions()

        logger.debug("Getting new \(chords.count) chords, \(notes.count) notes and \(history.count) history questions")

        await gameStorage.save(data: chords)
        await gameStorage.save(data: notes)
        await gameStorage.save(data: history)
    }
}
