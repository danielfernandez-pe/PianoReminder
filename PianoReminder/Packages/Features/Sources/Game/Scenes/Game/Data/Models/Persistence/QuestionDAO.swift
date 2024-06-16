//
//  QuestionDAO.swift
//
//
//  Created by Daniel Yopla on 09.04.2024.
//

import Foundation
import SwiftData

@Model
class QuestionDAO {
    func matchesChordId(_ chordId: String) -> Bool {
            return chord?.id == chordId
        }

    var id: String {
        if let chord {
            return chord.id
        }

        // TODO: add ids to note and history
        if let note {
            return ""
        }

        if let history {
            return ""
        }

        fatalError("Question without an entity should never happen")
    }

    var chord: ChordDTO?
    var note: SingleNoteDTO?
    var history: HistoryDTO?
    
    let isChordQuestion: Bool
    let isNoteQuestion: Bool
    let isHistoryQuestion: Bool
    
    var isUsed: Bool = false

    init(chord: ChordDTO?,
         note: SingleNoteDTO?,
         history: HistoryDTO?,
         isChordQuestion: Bool,
         isNoteQuestion: Bool,
         isHistoryQuestion: Bool) {
        self.chord = chord
        self.note = note
        self.history = history
        self.isChordQuestion = isChordQuestion
        self.isNoteQuestion = isNoteQuestion
        self.isHistoryQuestion = isHistoryQuestion
    }
}
