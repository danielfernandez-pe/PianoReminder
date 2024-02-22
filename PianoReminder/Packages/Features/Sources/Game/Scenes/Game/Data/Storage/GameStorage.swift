//
//  GameStorage.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation
import SwiftData
import Storage

final class GameStorage {
    private let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: SingleNoteDTO.self, ChordDTO.self)
        } catch {
            // log
            fatalError("Container not working")
        }
    }

    func save<T: PersistentModel>(data: [T]) async {
        let actor = BackgroundPersistenceModelActor(modelContainer: container)

        for model in data {
            await actor.insert(data: model)
        }

        do {
            try await actor.save()
        } catch {
            // log
        }
    }

    func fetchChords() async -> [ChordDTO] {
        let actor = BackgroundPersistenceModelActor(modelContainer: container)
        do {
            return try await actor.fetchData()
        } catch {
            return [] // from memory
        }
    }

    func fetchNotes() async -> [SingleNoteDTO] {
        let actor = BackgroundPersistenceModelActor(modelContainer: container)
        do {
            return try await actor.fetchData()
        } catch {
            return [] // from memory
        }
    }

//    func fetchStoryQuestions() async -> [ChordDTO] {
//        let actor = BackgroundPersistenceModelActor(modelContainer: container)
//        do {
//            return try await actor.fetchData()
//        } catch {
//            return [] // from memory
//        }
//    }
}
