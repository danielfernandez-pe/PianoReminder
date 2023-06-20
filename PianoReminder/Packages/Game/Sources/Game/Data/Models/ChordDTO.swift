//
//  ChordDTO.swift
//  
//
//  Created by Daniel Yopla on 15.06.2023.
//

import Foundation

protocol DTO: Decodable {
    associatedtype Model
    func toModel() -> Model
}

struct ChordDTO: DTO {
    typealias Model = Chord

    let notes: [ComposedNote]
    let clef: Clef
    let title: String

    func toModel() -> Chord {
        Chord(notes: notes, clef: clef, title: title)
    }
}
