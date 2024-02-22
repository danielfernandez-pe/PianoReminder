//
//  ComposedNoteDTO.swift
//  
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

enum NoteDTO: String, Codable {
    case c
    case d
    case e
    case f
    case g
    case a
    case b
}

enum NoteTypeDTO: String, Codable {
    case natural
    case flat
    case sharp
}

enum OctaveDTO: String, Codable {
    case oct1
    case oct2
    case oct3
    case middleC
    case oct5
    case oct6
    case oct7
}

struct ComposedNoteDTO: Codable {
    let value: NoteDTO
    let type: NoteTypeDTO
    let octave: OctaveDTO
    let extraSpaceForType: Bool

    init(value: NoteDTO, type: NoteTypeDTO, octave: OctaveDTO, extraSpaceForType: Bool = false) {
        self.value = value
        self.type = type
        self.octave = octave
        self.extraSpaceForType = extraSpaceForType
    }
}
