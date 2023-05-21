//
//  ChordQuestion.swift
//  
//
//  Created by Daniel Yopla on 20.05.2023.
//

import Foundation

public struct ChordQuestion {
    let question: Chord
    let options: [Option]

    public struct Option: Identifiable, Hashable {
        public let id = UUID().uuidString
        let value: Chord
        let isAnswer: Bool
    }
}
