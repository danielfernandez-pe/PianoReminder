//
//  GameRepositoryType.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

protocol GameRepositoryType {
    func sync(lastSynced: Date?) async throws
    func getQuestions(includeChords: Bool,
                      includeNotes: Bool,
                      includeStories: Bool,
                      limit: Int?) async -> [QuestionDOM]
}
