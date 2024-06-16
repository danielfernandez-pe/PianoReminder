//
//  SetupGameSessionUseCase.swift
//  
//
//  Created by Daniel Yopla on 20.06.2023.
//

import Foundation
import GameAPI
import Storage

struct SyncGameDataUseCase: SyncGameDataUseCaseType {
    private let gameRepository: any GameRepositoryType
    private let userDefaultsService: UserDefaultsService

    init(gameRepository: any GameRepositoryType, userDefaultsService: UserDefaultsService) {
        self.gameRepository = gameRepository
        self.userDefaultsService = userDefaultsService
    }

    func sync() async {
        let lastSynced = userDefaultsService.getLastSynced()

        do {
            try await gameRepository.sync(lastSynced: lastSynced)
            userDefaultsService.setLastSynced(to: .now)
        } catch {
            logger.error("Game sync fail. \(error.localizedDescription)")
        }
    }
}
