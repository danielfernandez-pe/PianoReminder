//
//  SingleNoteDTO.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

public struct SingleNoteDTO: DTO {
    typealias Model = SingleNote

    let value: Note
    let type: NoteType
    let octave: Octave
    let clef: Clef
    let title: String

    func toModel() -> SingleNote {
        SingleNote(value: value, type: type, octave: octave, clef: clef, title: title)
    }
}
