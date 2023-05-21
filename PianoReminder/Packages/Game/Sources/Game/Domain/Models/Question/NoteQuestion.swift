//
//  NoteQuestion.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Foundation

public struct NoteQuestion {
    let question: SingleNote
    let options: [Option]

    public struct Option: Identifiable, Hashable {
        public let id = UUID().uuidString
        let value: SingleNote
        let isAnswer: Bool
    }
}
