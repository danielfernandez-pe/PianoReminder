//
//  QuestionMapper.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

struct QuestionMapper {
    static func question(noteQuestion: NoteQuestion) -> Question {
        Question(
            options: noteQuestion.noteOptions.map { .init(title: $0.value.title, isAnswer: $0.isAnswer) },
            musicView: MusicView(type: .note(noteQuestion.question))
        )
    }

    static func question(chordQuestion: ChordQuestion) -> Question {
        Question(
            options: chordQuestion.chordOptions.map { .init(title: $0.value.title, isAnswer: $0.isAnswer) },
            musicView: MusicView(type: .chord(chordQuestion.question))
        )
    }
}
