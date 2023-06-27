//
//  DIContainer.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation
import Game
import DependencyInjection

final class DIContainer: DICProtocol {
    static let shared = DIContainer()

    private init() {
        registerModules()
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

    private func registerModules() {
        GameDI.register(container: self)
    }

    private func registerRouters() {
        register(type: HomeRouter.self, service: HomeRouter(container: self))
    }
}
