//
//  Router.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation

open class BaseCoordinator {
    public var coordinatorDidFinish: ((BaseCoordinator) -> Void)?
    public var id = UUID().uuidString
    var childCoordinators: [String: BaseCoordinator] = [:]

    public init() {}

    public func presentCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators[coordinator.id] = coordinator
        coordinator.start()
    }

    public func releaseCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators[coordinator.id] = nil
    }

    open func start() {
    }
}
