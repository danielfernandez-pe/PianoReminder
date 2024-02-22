//
//  File.swift
//  
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

// swiftlint:disable identifier_name
enum NoteUI: String, Hashable {
    case c
    case d
    case e
    case f
    case g
    case a
    case b
}
// swiftlint:enable identifier_name

enum NoteTypeUI: String, Hashable {
    case natural
    case flat
    case sharp
}

enum OctaveUI: String, Hashable {
    case oct1
    case oct2
    case oct3
    case middleC
    case oct5
    case oct6
    case oct7
}

struct ComposedNoteUI: Hashable {
    let value: NoteUI
    let type: NoteTypeUI
    let octave: OctaveUI
    let extraSpaceForType: Bool

    init(value: NoteUI, type: NoteTypeUI, octave: OctaveUI, extraSpaceForType: Bool = false) {
        self.value = value
        self.type = type
        self.octave = octave
        self.extraSpaceForType = extraSpaceForType
    }
}
