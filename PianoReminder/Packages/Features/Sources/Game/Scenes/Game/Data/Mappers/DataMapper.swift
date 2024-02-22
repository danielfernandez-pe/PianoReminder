//
//  DataMapper.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct DataMapper {
    static func singleNote(_ singleNote: SingleNoteDTO) -> SingleNoteDOM? {
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

    static func chord(_ chord: ChordDTO) -> ChordDOM? {
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

    static func story(_ story: StoryDTO) -> StoryDOM {
        let options = story.storyOptions.map { StoryDOM.Option(value: $0.value, isAnswer: $0.isAnswer) }
        return StoryDOM(titleQuestion: story.titleQuestion, storyOptions: options)
    }
}
