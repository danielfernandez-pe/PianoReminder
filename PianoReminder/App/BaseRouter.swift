// 
//  BaseRouter.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation

class BaseRouter<Path: Hashable> {
    @Published var paths: [Path] = []

    func push(_ path: Path) {
        paths.append(path)
    }

    func pop() {
        paths.removeLast()
    }

    func pop(to path: Path) {
        guard let destinationPathIndex = paths.firstIndex(where: { $0 == path }) else { return }
        let numToTop = (destinationPathIndex ..< paths.endIndex).count - 1
        paths.removeLast(numToTop)
    }

    func popToRoot() {
        paths.removeAll()
    }
}
