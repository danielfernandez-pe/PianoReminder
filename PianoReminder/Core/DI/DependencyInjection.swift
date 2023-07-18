//
//  DependencyInjection.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation
import Game
import DependencyInjection

final class DependencyInjection {
    static func setup() {
        GameDI.register(container: DIContainer.shared)
    }
}
