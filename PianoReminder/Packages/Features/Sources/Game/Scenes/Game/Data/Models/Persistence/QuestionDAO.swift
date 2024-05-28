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
    let chord: ChordDTO?
    let note: SingleNoteDTO?
    let history: HistoryDTO?
    
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
