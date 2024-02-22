//
//  SingleNoteDTO.swift
//
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation
import SwiftData

@Model
class SingleNoteDTO {
    let value: ComposedNoteDTO
    let clef: ClefDTO
    let title: String

    init(value: ComposedNoteDTO, clef: ClefDTO, title: String) {
        self.value = value
        self.clef = clef
        self.title = title
    }
}
