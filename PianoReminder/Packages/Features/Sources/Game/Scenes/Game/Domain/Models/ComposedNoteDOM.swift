//
//  ComposedNoteDOM.swift
//
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

// swiftlint:disable identifier_name
enum NoteDOM: String {
    case c
    case d
    case e
    case f
    case g
    case a
    case b
}
// swiftlint:enable identifier_name

enum NoteTypeDOM: String {
    case natural
    case flat
    case sharp
}

enum OctaveDOM: String {
    case oct1
    case oct2
    case oct3
    case middleC
    case oct5
    case oct6
    case oct7
}

struct ComposedNoteDOM {
    let value: NoteDOM
    let type: NoteTypeDOM
    let octave: OctaveDOM
    let extraSpaceForType: Bool

    init(value: NoteDOM, type: NoteTypeDOM, octave: OctaveDOM, extraSpaceForType: Bool = false) {
        self.value = value
        self.type = type
        self.octave = octave
        self.extraSpaceForType = extraSpaceForType
    }
}
