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
        case history(HistoryDOM)
    }

    let id = UUID().uuidString
    let questionType: QuestionType
    let category: CategoryDOM
    var options: [UserOptionDOM]

    var questionTitle: String {
        switch questionType {
        case .chord(let chordDOM):
            return chordDOM.title
        case .note(let singleNoteDOM):
            return singleNoteDOM.title
        case .history(let storyDOM):
            return storyDOM.titleQuestion
        }
    }

    var isChordQuestion: Bool {
        switch questionType {
        case .chord:
            return true
        default:
            return false
        }
    }

    var isNoteQuestion: Bool {
        switch questionType {
        case .note:
            return true
        default:
            return false
        }
    }

    var isHistoryQuestion: Bool {
        switch questionType {
        case .history:
            return true
        default:
            return false
        }
    }
}
