//
//  DataMapper.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct DataMapper {
    static func question(fromChord chord: ChordDAO) -> QuestionDOM {
        guard let domChord = Self.chord(chord) else {
            fatalError("This should never happend. There is a problem in the database types")
        }

        return QuestionDOM(questionType: .chord(domChord), category: .sightReading, options: [])
    }

    static func question(fromNote note: SingleNoteDAO) -> QuestionDOM {
        guard let domNote = Self.singleNote(note) else {
            fatalError("This should never happend. There is a problem in the database types")
        }

        return QuestionDOM(questionType: .note(domNote), category: .sightReading, options: [])
    }

    static func question(fromHistory history: HistoryDAO) -> QuestionDOM {
        return QuestionDOM(questionType: .history(Self.history(history)), category: .history, options: [])
    }

    private static func singleNote(_ singleNote: SingleNoteDAO) -> SingleNoteDOM? {
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

    private static func chord(_ chord: ChordDAO) -> ChordDOM? {
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

    private static func history(_ history: HistoryDAO) -> HistoryDOM {
        let options = history.historyOptions.map { HistoryDOM.Option(value: $0.value, isAnswer: $0.isAnswer) }
        return HistoryDOM(titleQuestion: history.titleQuestion, historyOptions: options)
    }
}
