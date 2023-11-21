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
            InMemoryChords.dMajor,
            InMemoryChords.eMajor,
            InMemoryChords.fMajor,
            InMemoryChords.gMajor,
            InMemoryChords.aMajor,
            InMemoryChords.bMajor,
            InMemoryChords.cMinor,
            InMemoryChords.dMinor,
            InMemoryChords.eMinor,
            InMemoryChords.fMinor,
            InMemoryChords.gMinor,
            InMemoryChords.aMinor,
            InMemoryChords.bMinor
        ]
    }
}

enum InMemoryChords {
    // MARK: - Treble basic Majors

    static let cMajor: ChordDTO = .init(
        notes: [
            .init(value: .c, type: .natural, octave: .middleC),
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "C Major"
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

    static let eMajor: ChordDTO = .init(
        notes: [
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .sharp, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "E Major"
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

    static let gMajor: ChordDTO = .init(
        notes: [
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "G Major"
    )

    static let aMajor: ChordDTO = .init(
        notes: [
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .sharp, octave: .oct5),
            .init(value: .e, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "A Major"
    )

    static let bMajor: ChordDTO = .init(
        notes: [
            .init(value: .b, type: .natural, octave: .middleC),
            .init(value: .d, type: .sharp, octave: .oct5, extraSpaceForType: true),
            .init(value: .f, type: .sharp, octave: .oct5)
        ],
        clef: .treble,
        title: "B Major"
    )

    // MARK: - Treble basic Minors

    static let cMinor: ChordDTO = .init(
        notes: [
            .init(value: .c, type: .natural, octave: .middleC),
            .init(value: .e, type: .flat, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "C Minor"
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

    static let eMinor: ChordDTO = .init(
        notes: [
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "E Minor"
    )

    static let fMinor: ChordDTO = .init(
        notes: [
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .flat, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "F Minor"
    )

    static let gMinor: ChordDTO = .init(
        notes: [
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .flat, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "G Minor"
    )

    static let aMinor: ChordDTO = .init(
        notes: [
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5),
            .init(value: .e, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "A Minor"
    )

    static let bMinor: ChordDTO = .init(
        notes: [
            .init(value: .b, type: .natural, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5),
            .init(value: .f, type: .sharp, octave: .oct5)
        ],
        clef: .treble,
        title: "B Minor"
    )
}
