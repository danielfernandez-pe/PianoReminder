//
//  GameRepositoryType.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

public protocol GameRepositoryType: ObservableObject {
    func setupGameSession() async throws

    func getNote() -> SingleNote
    func getChord() -> Chord
    func noteOptions() -> [SingleNote]
    func chordOptions() -> [Chord]
}
