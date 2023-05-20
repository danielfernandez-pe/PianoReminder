//
//  GameServiceType.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

public protocol GameServiceType {
    func fetchNotes() async throws -> [SingleNote]
    func fetchChords() async throws -> [Chord]
}
