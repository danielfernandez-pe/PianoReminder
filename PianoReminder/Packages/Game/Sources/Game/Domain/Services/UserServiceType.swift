//
//  UserServiceType.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Foundation

public enum GameType {
    case notes
    case chords
    case notesAndChords
}

public protocol UserServiceType {
    func getGameType() -> GameType
}
