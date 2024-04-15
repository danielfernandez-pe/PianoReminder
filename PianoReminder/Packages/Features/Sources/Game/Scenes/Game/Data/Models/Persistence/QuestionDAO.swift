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
    let story: StoryDTO?
    
    let isChordQuestion: Bool
    let isNoteQuestion: Bool
    let isStoryQuestion: Bool
    
    var isUsed: Bool = false

    init(chord: ChordDTO?,
         note: SingleNoteDTO?,
         story: StoryDTO?,
         isChordQuestion: Bool,
         isNoteQuestion: Bool,
         isStoryQuestion: Bool) {
        self.chord = chord
        self.note = note
        self.story = story
        self.isChordQuestion = isChordQuestion
        self.isNoteQuestion = isNoteQuestion
        self.isStoryQuestion = isStoryQuestion
    }
}
