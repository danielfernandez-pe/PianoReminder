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
        registerManagers()
    }

    private var services: [String: Any] = [:]

    func register<Service>(type: Service.Type, service: Any) {
        services["\(type)"] = service
    }

    func resolve<Service>(type: Service.Type) -> Service {
        guard let service = services["\(type)"] as? Service else {
            fatalError("App tried to resolve a service that wasn't registered before")
        }

        return service
    }

    private func registerServices() {
        register(type: GameServiceType.self, service: GameService())
    }

    private func registerDatabase() {
    }

    private func registerManagers() {
        guard let service: GameService = resolve(type: GameServiceType.self) as? GameService else {
            fatalError("GameService registered with error")
        }

        register(type: GameManager<GameService>.self, service: GameManager<GameService>(gameService: service))
    }
}
