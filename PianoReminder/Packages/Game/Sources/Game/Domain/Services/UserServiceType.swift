//
//  UserServiceType.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Foundation

enum GameType {
    case notes
    case chords
    case notesAndChords
}

protocol UserServiceType {
    func getGameType() -> GameType
}
