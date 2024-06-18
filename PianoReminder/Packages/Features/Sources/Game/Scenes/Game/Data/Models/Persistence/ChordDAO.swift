//
//  ChordDAO.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation
import SwiftData

@Model
class ChordDAO: Decodable {
    let id: String
    var notes: [ComposedNoteDTO]
    var clef: ClefDTO
    var title: String
    var category: CategoryDTO = CategoryDTO.sightReading

    init(id: String, notes: [ComposedNoteDTO], clef: ClefDTO, title: String) {
        self.id = id
        self.notes = notes
        self.clef = clef
        self.title = title
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.notes = try container.decode([ComposedNoteDTO].self, forKey: .notes)
        self.clef = try container.decode(ClefDTO.self, forKey: .clef)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decodeIfPresent(CategoryDTO.self, forKey: .category) ?? .sightReading
    }

    private enum CodingKeys: String, CodingKey {
        case id, notes, clef, title, category
    }
}
