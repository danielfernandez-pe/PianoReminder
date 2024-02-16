//
//  Question.swift
//  
//
//  Created by Daniel Yopla on 06.06.2023.
//

import SwiftUI

struct Question {
    let id = UUID()
    var options: [UserOption]
    var musicView: MusicView
}

extension Question: Equatable {
    static func ==(lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id
    }
}
