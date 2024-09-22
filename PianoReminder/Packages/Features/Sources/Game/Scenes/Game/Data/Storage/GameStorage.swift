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
    private lazy var actor = BackgroundPersistenceModelActor(modelContainer: container)

    init() {
        do {
            container = try ModelContainer(for: ChordDAO.self, SingleNoteDAO.self, HistoryDAO.self)
        } catch {
            // log
            fatalError("Container not working")
        }
    }

    func save<T: PersistentModel>(data: [T]) async {
        for model in data {
            await actor.insert(data: model)
        }

        do {
            try await actor.save()
            logger.debug("\(data.count) entities created successfully")
        } catch {
            // TODO: log
        }
    }

    func updateEntity<T: PersistentModel>(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async {
        do {
            let results = try await actor.fetchData(predicate: predicate)
            if results.isEmpty {
                logger.debug("No entity found to update")
                return
            }

            for question in results {
                updateBlock(question)
            }

            try await actor.save()
            logger.debug("entity updated successfully")
        } catch {
            // TODO: log
        }
    }

    func deleteEntity<T: PersistentModel>(predicate: Predicate<T>) async {
        do {
            let results = try await actor.fetchData(predicate: predicate)
            
            for question in results {
                await actor.delete(data: question)
            }

            try await actor.save()
            logger.debug("\(results.count) entities deleted successfully")
        } catch {
            // TODO: Log
        }
    }

    func fetchEntities<T: PersistentModel>(predicate: Predicate<T>? = nil,
                                           limit: Int? = nil) async -> [T] {
        do {
            return try await actor.fetchData(predicate: predicate, limit: limit)
        } catch {
            return [] // TODO: from memory
        }
    }
}
