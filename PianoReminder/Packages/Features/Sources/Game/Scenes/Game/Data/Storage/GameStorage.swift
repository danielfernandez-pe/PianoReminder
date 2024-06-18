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
            container = try ModelContainer(for: ChordDAO.self, SingleNoteDAO.self, HistoryDAO.self)
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
            logger.debug("\(data.count) questions created successfully")
        } catch {
            // TODO: log
        }
    }

    func updateEntity<T: PersistentModel>(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async {
        let actor = BackgroundPersistenceModelActor(modelContainer: container)

        do {
            let results = try await actor.fetchData(predicate: predicate)
            if results.isEmpty {
                logger.debug("No questions found to update")
                return
            }

            for question in results {
                updateBlock(question)
            }

            try await actor.save()
            logger.debug("question updated successfully")
        } catch {
            // TODO: log
        }
    }

    func deleteEntity<T: PersistentModel>(predicate: Predicate<T>) async {
        let actor = BackgroundPersistenceModelActor(modelContainer: container)

        do {
            let results = try await actor.fetchData(predicate: predicate)
            
            for question in results {
                await actor.delete(data: question)
            }

            try await actor.save()
            logger.debug("\(results.count) questions deleted successfully")
        } catch {
            // TODO: Log
        }
    }

    func fetchEntities<T: PersistentModel>(predicate: Predicate<T>? = nil,
                                           limit: Int? = nil) async -> [T] {
        let actor = BackgroundPersistenceModelActor(modelContainer: container)
        do {
            return try await actor.fetchData(predicate: predicate, limit: limit)
        } catch {
            return [] // TODO: from memory
        }
    }
}
