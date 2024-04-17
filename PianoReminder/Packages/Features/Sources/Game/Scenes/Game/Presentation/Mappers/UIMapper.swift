//
//  UIMapper.swift
//
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

struct UIMapper {
    static func question(_ question: QuestionDOM) -> QuestionUI? {
        guard let category = CategoryUI(rawValue: question.category.rawValue) else {
            return nil
        }

        let questionOptions = question.options.map {
            UserOptionUI(title: $0.title, isAnswer: $0.isAnswer)
        }
        let questionViewType: QuestionUI.QuestionViewType

        switch question.questionType {
        case .chord(let chordDOM):
            let notes = chordDOM.notes.compactMap { chord -> ComposedNoteUI? in
                guard let value = NoteUI(rawValue: chord.value.rawValue),
                      let type = NoteTypeUI(rawValue: chord.type.rawValue),
                      let octave = OctaveUI(rawValue: chord.octave.rawValue) else { return nil }
                return ComposedNoteUI(value: value, type: type, octave: octave, extraSpaceForType: chord.extraSpaceForType)
            }
            guard let clef = ClefUI(rawValue: chordDOM.clef.rawValue) else { return nil }
            questionViewType = QuestionUI.QuestionViewType.chord(.init(notes: notes, clef: clef))
        case .note(let singleNoteDOM):
            guard let value = NoteUI(rawValue: singleNoteDOM.value.value.rawValue),
                  let type = NoteTypeUI(rawValue: singleNoteDOM.value.type.rawValue),
                  let octave = OctaveUI(rawValue: singleNoteDOM.value.octave.rawValue),
                  let clef = ClefUI(rawValue: singleNoteDOM.clef.rawValue) else { return nil }
            let note = ComposedNoteUI(value: value, type: type, octave: octave)
            questionViewType = QuestionUI.QuestionViewType.note(.init(value: note, clef: clef, title: singleNoteDOM.title))
        case .story(let storyDOM):
            let options = storyDOM.storyOptions.map {
                StoryUI.Option(value: $0.value, isAnswer: $0.isAnswer)
            }
            questionViewType = QuestionUI.QuestionViewType.story(.init(titleQuestion: storyDOM.titleQuestion, storyOptions: options))
        }

        return QuestionUI(
            id: question.id,
            options: questionOptions,
            questionViewType: questionViewType,
            category: category
        )
    }
}
