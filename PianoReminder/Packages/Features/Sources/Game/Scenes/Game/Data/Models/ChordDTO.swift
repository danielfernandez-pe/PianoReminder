//
//  ChordDTO.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

struct ChordDTO: Codable {
    let notes: [ComposedNoteDTO]
    let clef: ClefDTO
    let title: String
    var category: CategoryDTO = CategoryDTO.sightReading
}
