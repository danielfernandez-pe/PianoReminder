//
//  Router.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation

open class Router<Path: Hashable> {
    @Published public var paths: [Path] = []

    public init() {}

    public func push(_ path: Path) {
        paths.append(path)
    }

    public func pop() {
        paths.removeLast()
    }

    public func pop(to path: Path) {
        guard let destinationPathIndex = paths.firstIndex(where: { $0 == path }) else { return }
        let numToTop = (destinationPathIndex ..< paths.endIndex).count - 1
        paths.removeLast(numToTop)
    }

    public func popToRoot() {
        paths.removeAll()
    }
}
