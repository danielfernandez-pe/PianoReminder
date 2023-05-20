//
//  DIContainer.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation
import Game

protocol DICProtocol {
    func register<Service>(type: Service.Type, service: Any)
    func resolve<Service>(type: Service.Type) -> Service
}

final class DIContainer: DICProtocol {
    static let shared = DIContainer()

    private init() {
        registerServices()
        registerDatabase()
        registerRepositories()
        registerRouters()
    }

    private var services: [String: Any] = [:]

    func register<Service>(type: Service.Type, service: Any) {
        services["\(type)"] = service
    }

    func resolve<Service>(type: Service.Type) -> Service {
        guard let service = services["\(type)"] as? Service else {
            fatalError("App tried to resolve a service \(type) that wasn't registered before")
        }

        return service
    }

    private func registerServices() {
        register(type: GameServiceType.self, service: GameService())
        register(type: UserServiceType.self, service: UserService())
    }

    private func registerDatabase() {
    }

    private func registerRouters() {
        register(type: HomeRouter.self, service: HomeRouter())
    }

    private func registerRepositories() {
        guard let gameService: GameService = resolve(type: GameServiceType.self) as? GameService else {
            fatalError("GameService registered with error")
        }

        guard let userService: UserService = resolve(type: UserServiceType.self) as? UserService else {
            fatalError("UserService registered with error")
        }

        register(type: (any GameRepositoryType).self, service: GameRepository<GameService>(gameService: gameService))
        register(type: (any UserSettingsRepositoryType).self, service: UserSettingsRepository<UserService>(userService: userService))
    }
}
