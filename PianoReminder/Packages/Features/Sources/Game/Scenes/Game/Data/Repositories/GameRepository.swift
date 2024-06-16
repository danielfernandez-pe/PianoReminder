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

    func sync(lastSynced: String?) async throws {
        if let lastSynced {
            logger.debug("Starting incremental sync from \(lastSynced)")
            let entitiesToSync = try await gameService.fetchEntitiesToSync(from: lastSynced)
            for entityToSync in entitiesToSync {
                switch entityToSync.path {
                case .chords:
                    await syncChord(entity: entityToSync)
                case .notes:
                    await syncNote(entity: entityToSync)
                case .history:
                    await syncHistory(entity: entityToSync)
                default:
                    break
                }
            }
        } else {
            try await syncAll()
        }
    }

    private func syncChord(entity: EntityToSyncDTO) async {
        do {
            let chord = try await gameService.fetchChord(id: entity.entityId)
            switch entity.syncType {
            case .created:
                let unsyncQuestion = QuestionDAO(
                    chord: chord,
                    note: nil,
                    history: nil,
                    isChordQuestion: true,
                    isNoteQuestion: false,
                    isHistoryQuestion: false
                )
                await gameStorage.save(data: [unsyncQuestion])
            case .updated:
                let entityId = entity.entityId
                let predicate = #Predicate<QuestionDAO> { question in
                    question.isChordQuestion && question.chord?.id == entityId
                }

                await gameStorage.updateQuestion(predicate: predicate) { question in
//                    question.chord = chord
                }
            case .deleted:
                break
//                let entityId = entity.entityId
//                let predicate = #Predicate<QuestionDAO> { question in
//                    if let chordId = question.chord?.id {
//                        return chordId == entityId
//                    } else {
//                        return false
//                    }
//                }
//
//                await gameStorage.deleteQuestion(predicate: predicate)
            }
        } catch {
            logger.error("Error fetching chord \(error.localizedDescription)")
        }
    }

    private func syncNote(entity: EntityToSyncDTO) async {
        do {
            let unsyncNote = try await gameService.fetchNote(id: entity.entityId)
        } catch {
            
        }
    }

    private func syncHistory(entity: EntityToSyncDTO) async {
        do {
            let unsyncHistory = try await gameService.fetchHistory(id: entity.entityId)
        } catch {
            
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
