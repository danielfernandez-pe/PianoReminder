//
//  SingleNoteDAO.swift
//
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation
import SwiftData

@Model
class SingleNoteDAO: Decodable {
    let value: ComposedNoteDTO
    let clef: ClefDTO
    let title: String
    var category: CategoryDTO = CategoryDTO.sightReading

    init(value: ComposedNoteDTO, clef: ClefDTO, title: String) {
        self.value = value
        self.clef = clef
        self.title = title
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(ComposedNoteDTO.self, forKey: .value)
        self.clef = try container.decode(ClefDTO.self, forKey: .clef)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decodeIfPresent(CategoryDTO.self, forKey: .category) ?? .sightReading
    }

    private enum CodingKeys: String, CodingKey {
        case title, clef, value, category
    }
}
