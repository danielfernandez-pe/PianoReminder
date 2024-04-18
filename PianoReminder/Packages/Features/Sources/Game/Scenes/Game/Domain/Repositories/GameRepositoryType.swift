//
//  GameRepositoryType.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

protocol GameRepositoryType {
    func sync() async
    func getQuestions(includeChords: Bool,
                      includeNotes: Bool,
                      includeStories: Bool,
                      limit: Int?) async -> [QuestionDOM]
}
