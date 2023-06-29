//
//  Routing.swift
//  
//
//  Created by Daniel Yopla on 29.06.2023.
//

import Combine
import SwiftUI

public protocol Routing {
    associatedtype Content: View

    var didFinish: AnyPublisher<Void, Never> { get }

    func start() -> Content
}
