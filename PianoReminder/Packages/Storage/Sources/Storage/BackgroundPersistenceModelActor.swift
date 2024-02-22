//
//  BackgroundPersistenceModelActor.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation
import SwiftData

public actor BackgroundPersistenceModelActor: ModelActor {
    public let modelContainer: ModelContainer
    public let modelExecutor: ModelExecutor

    private var context: ModelContext { modelExecutor.modelContext }

    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        let context = ModelContext(modelContainer)
        // this guarantees thread safety since accessing container in multiple threads my lead to a crash
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    public func insert<T: PersistentModel>(data: T) {
        context.insert(data)
    }

    public func save() throws {
        try context.save()
    }

    public func fetchData<T: PersistentModel>(predicate: Predicate<T>? = nil, sortBy: [SortDescriptor<T>] = []) throws -> [T] {
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        let list: [T] = try context.fetch(fetchDescriptor)
        return list
    }
}