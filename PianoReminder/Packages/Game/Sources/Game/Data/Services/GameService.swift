//
//  GameService.swift
//  
//
//  Created by Daniel Yopla on 26.04.2023.
//

import Foundation

public final class GameService: GameServiceType {
    public init() {}

    public func fetchNotes() async throws -> [SingleNote] {
        [
            .init(value: .c, type: .natural, octave: .middleC, clef: .treble),
            .init(value: .g, type: .flat, octave: .oct1, clef: .bass),
            .init(value: .e, type: .flat, octave: .oct3, clef: .bass),
            .init(value: .c, type: .sharp, octave: .oct5, clef: .treble),
            .init(value: .b, type: .flat, octave: .oct2, clef: .bass),
            .init(value: .d, type: .natural, octave: .middleC, clef: .treble),
            .init(value: .f, type: .sharp, octave: .oct3, clef: .treble),
            .init(value: .g, type: .natural, octave: .oct5, clef: .treble),
            .init(value: .b, type: .natural, octave: .oct3, clef: .bass),
            .init(value: .d, type: .flat, octave: .middleC, clef: .treble)
        ]
    }

    public func fetchChords() async throws -> [ChordNote] {
        [
            InMemoryChords.cMajor,
            InMemoryChords.fMajor,
            InMemoryChords.dMinor,
            InMemoryChords.dMajor,
            InMemoryChords.gMajor
        ]
    }
}

public enum InMemoryChords {
    static let cMajor: ChordNote = .init(
        notes: [
            .init(value: .c, type: .natural, octave: .middleC),
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC)
        ],
        clef: .treble
    )

    static let fMajor: ChordNote = .init(
        notes: [
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5)
        ],
        clef: .treble
    )

    static let dMinor: ChordNote = .init(
        notes: [
            .init(value: .d, type: .natural, octave: .middleC),
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC)
        ],
        clef: .treble
    )

    static let dMajor: ChordNote = .init(
        notes: [
            .init(value: .d, type: .natural, octave: .middleC),
            .init(value: .f, type: .sharp, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC)
        ],
        clef: .treble
    )

    static let gMajor: ChordNote = .init(
        notes: [
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5)
        ],
        clef: .treble
    )
}
