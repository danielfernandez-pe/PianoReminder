//
//  QuestionUI.swift
//  
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct QuestionUI: Hashable {
    enum QuestionViewType: Hashable {
        case chord(ChordUI)
        case note(SingleNoteUI)
        case story(StoryUI)
    }

    let options: [UserOptionUI]
    let questionViewType: QuestionViewType
    let category: CategoryUI
}
