//
//  QuestionDOM.swift
//
//
//  Created by Daniel Yopla on 06.06.2023.
//

import SwiftUI

struct QuestionDOM {
    enum QuestionType {
        case chord(ChordDOM)
        case note(SingleNoteDOM)
        case story(StoryDOM)
    }

    let questionType: QuestionType
    let category: CategoryDOM
    var options: [UserOptionDOM]
}
