//
//  File.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation

struct SetupGameSessionUseCase {
    private let gameRepository: any GameRepositoryType

    init(gameRepository: any GameRepositoryType) {
        self.gameRepository = gameRepository
    }

    func setupGameSession() async throws {
        try await gameRepository.setupGameSession()
    }
}
