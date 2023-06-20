//
//  GameServiceType.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

protocol GameServiceType {
    func fetchNotes() async throws -> [SingleNoteDTO]
    func fetchChords() async throws -> [ChordDTO]
}
