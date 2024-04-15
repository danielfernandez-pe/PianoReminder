//
//  SingleNoteDTO.swift
//
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

struct SingleNoteDTO: Codable {
    let value: ComposedNoteDTO
    let clef: ClefDTO
    let title: String
    var category: CategoryDTO = CategoryDTO.sightReading
}
