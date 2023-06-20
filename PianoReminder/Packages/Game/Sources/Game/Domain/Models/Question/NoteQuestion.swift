//
//  NoteQuestion.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import SwiftUI

public struct NoteQuestion {
    let question: SingleNote
    let noteOptions: [Option]

    public struct Option: Identifiable, Hashable {
        public let id = UUID().uuidString
        let value: SingleNote
        let isAnswer: Bool
    }
}
