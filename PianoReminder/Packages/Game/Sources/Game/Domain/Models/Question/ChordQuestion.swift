//
//  ChordQuestion.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import SwiftUI

struct ChordQuestion {
    let question: Chord
    let chordOptions: [Option]

    struct Option: Identifiable, Hashable {
        let id = UUID().uuidString
        let value: Chord
        let isAnswer: Bool
    }
}
