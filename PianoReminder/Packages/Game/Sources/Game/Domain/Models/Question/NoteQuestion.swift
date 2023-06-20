//
//  NoteQuestion.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import SwiftUI

struct NoteQuestion {
    let question: SingleNote
    let noteOptions: [Option]

    struct Option: Identifiable, Hashable {
        let id = UUID().uuidString
        let value: SingleNote
        let isAnswer: Bool
    }
}
