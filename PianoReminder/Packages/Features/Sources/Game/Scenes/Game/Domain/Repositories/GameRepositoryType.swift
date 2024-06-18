//
//  GameRepositoryType.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

protocol GameRepositoryType {
    func sync(lastSynced: String?) async throws
    func getQuestions(includeChords: Bool,
                      includeNotes: Bool,
                      includeHistory: Bool,
                      limit: Int?) async -> [QuestionDOM]
}
