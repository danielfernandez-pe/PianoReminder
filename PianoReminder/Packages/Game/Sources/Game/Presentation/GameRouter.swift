//
//  GameRouter.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Combine
import Core
import SwiftUI

final class GameRouter: Router<GameRouter.Path>, ObservableObject {
    enum Path {
        case overview

        var screen: some View {
            return fatalError("Not yet")
        }
    }
}
