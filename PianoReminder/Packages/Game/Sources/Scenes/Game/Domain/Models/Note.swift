//
//  Note.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

// swiftlint:disable identifier_name
enum Note: Hashable, Decodable {
    case c
    case d
    case e
    case f
    case g
    case a
    case b
}
// swiftlint:enable identifier_name

struct ComposedNote: Hashable, Decodable {
    let value: Note
    let type: NoteType
    let octave: Octave
}

// Structure for rendering one note in the Bar
struct SingleNote: Hashable, Decodable {
    let value: Note
    let type: NoteType
    let octave: Octave
    let clef: Clef
    let title: String
}

// Structure for rendering one chord in the Bar
struct Chord: Hashable, Decodable {
    let notes: [ComposedNote]
    let clef: Clef
    let title: String
}
