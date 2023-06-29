//
//  Router.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation

open class BaseRouter<Path: Hashable>: ObservableObject {
    @Published public var paths: [Path] = []

    public init() {}

    open func push(_ path: Path) {
        paths.append(path)
    }

    public func pop() {
        guard paths.count > 1 else { return }
        paths.removeLast()
    }

    public func pop(to path: Path) {
        guard let destinationPathIndex = paths.firstIndex(where: { $0 == path }) else { return }
        let numToTop = (destinationPathIndex ..< paths.endIndex).count - 1
        paths.removeLast(numToTop)
    }

    public func popToRoot() {
        guard !paths.isEmpty, let first = paths.first else { return }
        paths = [first]
    }
}
