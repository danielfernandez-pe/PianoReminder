//
//  QuestionUI.swift
//  
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct QuestionUI: Identifiable, Hashable {
    enum QuestionViewType: Hashable {
        case chord(ChordUI)
        case note(SingleNoteUI)
        case history(HistoryUI)
    }

    let id: String
    let options: [UserOptionUI]
    let questionViewType: QuestionViewType
    let category: CategoryUI
}
