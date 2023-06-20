//
//  HomeRouter.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Combine
import SwiftUI
import Core
import Game

final class HomeRouter: Router<HomeRouter.Path>, ObservableObject {
    enum Path {
        case game
    }
}
