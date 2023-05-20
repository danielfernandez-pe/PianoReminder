//
//  Note.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import Foundation

// swiftlint:disable identifier_name
public enum Note: Hashable {
    case c
    case d
    case e
    case f
    case g
    case a
    case b
}
// swiftlint:enable identifier_name

public struct ComposedNote: Hashable {
    let value: Note
    let type: NoteType
    let octave: Octave
}

// Structure for rendering one note in the Bar
public struct SingleNote: Hashable {
    let value: Note
    let type: NoteType
    let octave: Octave
    let clef: Clef
    let title: String
}

// Structure for rendering one chord in the Bar
public struct Chord: Hashable {
    let notes: [ComposedNote]
    let clef: Clef
    let title: String
}
