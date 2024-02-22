//
//  ChordDTO.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation
import SwiftData

@Model
class ChordDTO {
    let notes: [ComposedNoteDTO]
    let clef: ClefDTO
    let title: String

    init(notes: [ComposedNoteDTO], clef: ClefDTO, title: String) {
        self.notes = notes
        self.clef = clef
        self.title = title
    }
}

// TODO: logic for gaming

/// 1. Before we start the session we get all ChordDTO and transform to ChordSessionDOM (persisted as well)
/// 2. During the session, use case will grab 20 chordSessions, mark them as used = true
/// 3. Once user is reaching the last of this, we will call again for new 20 chordSessions that have used as false
/// 4. We repeat this until is done then we can delete all chordSessions in the background
/// 5. If there is no more chordSessions, we grab start grabbing also the used equal true as well (we repeat)

