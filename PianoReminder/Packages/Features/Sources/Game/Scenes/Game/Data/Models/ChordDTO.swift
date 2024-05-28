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

    init(notes: [ComposedNoteDTO], clef: ClefDTO, title: String) {
        self.notes = notes
        self.clef = clef
        self.title = title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.notes = try container.decode([ComposedNoteDTO].self, forKey: .notes)
        self.clef = try container.decode(ClefDTO.self, forKey: .clef)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decodeIfPresent(CategoryDTO.self, forKey: .category) ?? .sightReading
    }

    private enum CodingKeys: String, CodingKey {
        case notes, clef, title, category
    }
}
