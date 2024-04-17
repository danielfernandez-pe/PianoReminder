//
//  StorageDI.swift
//
//
//  Created by Daniel Yopla on 17.04.2024.
//

import DependencyInjection
import Lumberjack

var logger: LumberjackCoordinator!

public struct StorageDI {
    public static func register(container: DICProtocol) {
        logger = container.resolveService(LumberjackCoordinator.self)
    }
}
