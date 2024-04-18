//
//  GameService.swift
//  
//
//  Created by Daniel Yopla on 26.04.2023.
//

import Foundation

final class GameService {
    func fetchNotes() async throws -> [SingleNoteDTO] {
        [
            .init(value: .init(value: .c, type: .sharp, octave: .oct5), clef: .treble, title: "C flat"),
            .init(value: .init(value: .c, type: .natural, octave: .middleC), clef: .treble, title: "C"),
            .init(value: .init(value: .d, type: .flat, octave: .middleC), clef: .treble, title: "D flat"),
            .init(value: .init(value: .d, type: .natural, octave: .middleC), clef: .treble, title: "D"),
            .init(value: .init(value: .e, type: .flat, octave: .oct3), clef: .bass, title: "E flat"),
            .init(value: .init(value: .f, type: .sharp, octave: .oct3), clef: .treble, title: "F sharp"),
            .init(value: .init(value: .g, type: .flat, octave: .oct1), clef: .bass, title: "G flat"),
            .init(value: .init(value: .g, type: .natural, octave: .oct5), clef: .treble, title: "G"),
            .init(value: .init(value: .b, type: .flat, octave: .oct2), clef: .bass, title: "B flat"),
            .init(value: .init(value: .b, type: .natural, octave: .oct3), clef: .bass, title: "B")
        ]
    }

    func fetchChords() async throws -> [ChordDTO] {
        [
            trebleBasicMajors(),
            trebleBasicMinors(),
            bassBasicMajors(),
            bassBasicMinors()
        ].flatMap { $0 }.shuffled()
    }

    func fetchStoryQuestions() async throws -> [StoryDTO] {
        [
            .init(
                titleQuestion: "1When was the piano invented?",
                storyOptions: [
                    .init(value: "1920", isAnswer: false),
                    .init(value: "1850", isAnswer: false),
                    .init(value: "1509", isAnswer: true),
                    .init(value: "345", isAnswer: false)
                ]
            ),
            .init(
                titleQuestion: "2Who invented the piano?",
                storyOptions: [
                    .init(value: "Daniel Fernandez", isAnswer: true),
                    .init(value: "Lima", isAnswer: false),
                    .init(value: "Lucky", isAnswer: true),
                    .init(value: "Pocho", isAnswer: false)
                ]
            ),
            .init(
                titleQuestion: "3What was the first piece ever played?",
                storyOptions: [
                    .init(value: "Bohemian rhapsody", isAnswer: false),
                    .init(value: "American idiot", isAnswer: false),
                    .init(value: "Karma police", isAnswer: true),
                ]
            ),
            .init(
                titleQuestion: "4Which instrument was first?",
                storyOptions: [
                    .init(value: "Guitar", isAnswer: false),
                    .init(value: "Piano", isAnswer: true)
                ]
            )
        ]
    }

    private func trebleBasicMajors() -> [ChordDTO] {
        [
            InMemoryChords.cMajor,
            InMemoryChords.dMajor,
            InMemoryChords.eMajor,
            InMemoryChords.fMajor,
            InMemoryChords.gMajor,
            InMemoryChords.aMajor,
            InMemoryChords.bMajor
        ]
    }

    private func trebleBasicMinors() -> [ChordDTO] {
        [
            InMemoryChords.cMinor,
            InMemoryChords.dMinor,
            InMemoryChords.eMinor,
            InMemoryChords.fMinor,
            InMemoryChords.gMinor,
            InMemoryChords.aMinor,
            InMemoryChords.bMinor
        ]
    }

    private func bassBasicMajors() -> [ChordDTO] {
        [
            InMemoryChords.cBassMajor,
            InMemoryChords.dBassMajor,
            InMemoryChords.eBassMajor,
            InMemoryChords.fBassMajor,
            InMemoryChords.gBassMajor,
            InMemoryChords.aBassMajor,
            InMemoryChords.bBassMajor
        ]
    }

    private func bassBasicMinors() -> [ChordDTO] {
        [
            InMemoryChords.cBassMinor,
            InMemoryChords.dBassMinor,
            InMemoryChords.eBassMinor,
            InMemoryChords.fBassMinor,
            InMemoryChords.gBassMinor,
            InMemoryChords.aBassMinor,
            InMemoryChords.bBassMinor
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

    // MARK: - Bass basic Majors

    static let cBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .c, type: .natural, octave: .oct3),
            .init(value: .e, type: .natural, octave: .oct3),
            .init(value: .g, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "C Major"
    )

    static let dBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .d, type: .natural, octave: .oct3),
            .init(value: .f, type: .sharp, octave: .oct3),
            .init(value: .a, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "D Major"
    )

    static let eBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .e, type: .natural, octave: .oct3),
            .init(value: .g, type: .sharp, octave: .oct3),
            .init(value: .b, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "E Major"
    )

    static let fBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .f, type: .natural, octave: .oct3),
            .init(value: .a, type: .natural, octave: .oct3),
            .init(value: .c, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "F Major"
    )

    static let gBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .g, type: .natural, octave: .oct3),
            .init(value: .b, type: .natural, octave: .oct3),
            .init(value: .d, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "G Major"
    )

    static let aBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .a, type: .natural, octave: .oct2),
            .init(value: .c, type: .sharp, octave: .oct3),
            .init(value: .e, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "A Major"
    )

    static let bBassMajor: ChordDTO = .init(
        notes: [
            .init(value: .b, type: .natural, octave: .oct2),
            .init(value: .d, type: .sharp, octave: .oct3),
            .init(value: .f, type: .sharp, octave: .oct3)
        ],
        clef: .bass,
        title: "B Major"
    )

    // MARK: - Bass basic Minors

    static let cBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .c, type: .natural, octave: .oct3),
            .init(value: .e, type: .flat, octave: .oct3),
            .init(value: .g, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "C Minor"
    )

    static let dBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .d, type: .natural, octave: .oct3),
            .init(value: .f, type: .natural, octave: .oct3),
            .init(value: .a, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "D Minor"
    )

    static let eBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .e, type: .natural, octave: .oct3),
            .init(value: .g, type: .natural, octave: .oct3),
            .init(value: .b, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "E Minor"
    )

    static let fBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .f, type: .natural, octave: .oct3),
            .init(value: .a, type: .flat, octave: .oct3),
            .init(value: .c, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "F Minor"
    )

    static let gBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .g, type: .natural, octave: .oct3),
            .init(value: .b, type: .flat, octave: .oct3),
            .init(value: .d, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "G Minor"
    )

    static let aBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .a, type: .natural, octave: .oct2),
            .init(value: .c, type: .natural, octave: .oct3),
            .init(value: .e, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "A Minor"
    )

    static let bBassMinor: ChordDTO = .init(
        notes: [
            .init(value: .b, type: .natural, octave: .oct2),
            .init(value: .d, type: .natural, octave: .oct3),
            .init(value: .f, type: .sharp, octave: .oct3)
        ],
        clef: .bass,
        title: "B Minor"
    )
}
