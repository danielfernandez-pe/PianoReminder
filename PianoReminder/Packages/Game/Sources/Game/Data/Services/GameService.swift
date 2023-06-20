//
//  GameService.swift
//  
//
//  Created by Daniel Yopla on 26.04.2023.
//

import Foundation

final class GameService: GameServiceType {
    init() {}

    func fetchNotes() async throws -> [SingleNoteDTO] {
        [
            .init(value: .c, type: .natural, octave: .middleC, clef: .treble, title: "C"),
            .init(value: .g, type: .flat, octave: .oct1, clef: .bass, title: "G flat"),
            .init(value: .e, type: .flat, octave: .oct3, clef: .bass, title: "E flat"),
            .init(value: .c, type: .sharp, octave: .oct5, clef: .treble, title: "C sharp"),
            .init(value: .b, type: .flat, octave: .oct2, clef: .bass, title: "B flat"),
            .init(value: .d, type: .natural, octave: .middleC, clef: .treble, title: "D"),
            .init(value: .f, type: .sharp, octave: .oct3, clef: .treble, title: "F sharp"),
            .init(value: .g, type: .natural, octave: .oct5, clef: .treble, title: "G"),
            .init(value: .b, type: .natural, octave: .oct3, clef: .bass, title: "B"),
            .init(value: .d, type: .flat, octave: .middleC, clef: .treble, title: "D flat")
        ]
    }

    func fetchChords() async throws -> [ChordDTO] {
        [
            InMemoryChords.cMajor,
            InMemoryChords.fMajor,
            InMemoryChords.dMinor,
            InMemoryChords.dMajor,
            InMemoryChords.gMajor
        ]
    }
}

enum InMemoryChords {
    static let cMajor: ChordDTO = .init(
        notes: [
            .init(value: .c, type: .natural, octave: .middleC),
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "C Major"
    )

    static let fMajor: ChordDTO = .init(
        notes: [
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "F Major"
    )

    static let dMinor: ChordDTO = .init(
        notes: [
            .init(value: .d, type: .natural, octave: .middleC),
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "D Minor"
    )

    static let dMajor: ChordDTO = .init(
        notes: [
            .init(value: .d, type: .natural, octave: .middleC),
            .init(value: .f, type: .sharp, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "D Major"
    )

    static let gMajor: ChordDTO = .init(
        notes: [
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "G Major"
    )
}
