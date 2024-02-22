//
//  SetupGameSessionUseCase.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation
import GameAPI

struct SyncGameDataUseCase: SyncGameDataUseCaseType {
    private let gameRepository: any GameRepositoryType

    init(gameRepository: any GameRepositoryType) {
        self.gameRepository = gameRepository
    }

    func sync() async {
        await gameRepository.sync()
    }
}
