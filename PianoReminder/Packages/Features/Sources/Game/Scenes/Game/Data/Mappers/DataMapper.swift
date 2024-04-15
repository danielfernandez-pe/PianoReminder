//
//  DataMapper.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct DataMapper {
    static func question(_ questionDao: QuestionDAO) -> QuestionDOM {
        var questionType: QuestionDOM.QuestionType!
        var category: CategoryDOM = .sightReading

        if questionDao.isChordQuestion, let chord = questionDao.chord, let chordDom = Self.chord(chord) {
            questionType = .chord(chordDom)
            category = .sightReading
        }

        if questionDao.isNoteQuestion, let note = questionDao.note, let noteDom = Self.singleNote(note) {
            questionType = .note(noteDom)
            category = .sightReading
        }

        if questionDao.isStoryQuestion, let story = questionDao.story {
            let storyDom = Self.story(story)
            questionType = .story(storyDom)
            category = .story
        }

        return QuestionDOM(questionType: questionType, category: category, options: [])
    }

    private static func singleNote(_ singleNote: SingleNoteDTO) -> SingleNoteDOM? {
        guard let clef = ClefDOM(rawValue: singleNote.clef.rawValue),
              let note = NoteDOM(rawValue: singleNote.value.value.rawValue),
              let type = NoteTypeDOM(rawValue: singleNote.value.type.rawValue),
              let octave = OctaveDOM(rawValue: singleNote.value.octave.rawValue) else { return nil }
        return SingleNoteDOM(
            value: .init(
                value: note,
                type: type,
                octave: octave
            ),
            clef: clef,
            title: singleNote.title
        )
    }

    private static func chord(_ chord: ChordDTO) -> ChordDOM? {
        guard let clef = ClefDOM(rawValue: chord.clef.rawValue) else { return nil }
        let notes: [ComposedNoteDOM] = chord.notes.compactMap { composedNote -> ComposedNoteDOM? in
            guard let note = NoteDOM(rawValue: composedNote.value.rawValue),
                  let type = NoteTypeDOM(rawValue: composedNote.type.rawValue),
                  let octave = OctaveDOM(rawValue: composedNote.octave.rawValue) else { return nil }
            return ComposedNoteDOM(
                value: note,
                type: type,
                octave: octave,
                extraSpaceForType: composedNote.extraSpaceForType
            )
        }

        return ChordDOM(
            notes: notes,
            clef: clef,
            title: chord.title
        )
    }

    private static func story(_ story: StoryDTO) -> StoryDOM {
        let options = story.storyOptions.map { StoryDOM.Option(value: $0.value, isAnswer: $0.isAnswer) }
        return StoryDOM(titleQuestion: story.titleQuestion, storyOptions: options)
    }
}
