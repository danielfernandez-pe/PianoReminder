//
//  GameService.swift
//  
//
//  Created by Daniel Yopla on 26.04.2023.
//

import Foundation
import Networking

final class GameService {
    enum FirebaseCollection: String, Decodable {
        case chords
        case notes
        case history
        case sync

        func getPathWithLocale() -> String {
            let mainPath = "questions/EN/"
            return "\(mainPath)\(rawValue)"
        }
    }

    private let networking: FirebaseNetworking

    init(networking: FirebaseNetworking) {
        self.networking = networking
    }

    func fetchEntitiesToSync(from lastSynced: String) async throws -> [EntityToSyncDTO] {
        let data = try await networking.get(path: FirebaseCollection.sync.rawValue, queryField: "modified", value: lastSynced)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([EntityToSyncDTO].self, from: data)
    }

    func fetchChord(id: String) async throws -> ChordDTO {
        let data = try await networking.getDocument(path: FirebaseCollection.chords.getPathWithLocale(), id: id)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(ChordDTO.self, from: data)
    }

    func fetchNote(id: String) async throws -> SingleNoteDTO {
        let data = try await networking.getDocument(path: FirebaseCollection.notes.getPathWithLocale(), id: id)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(SingleNoteDTO.self, from: data)
    }

    func fetchHistory(id: String) async throws -> HistoryDTO {
        let data = try await networking.getDocument(path: FirebaseCollection.history.getPathWithLocale(), id: id)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(HistoryDTO.self, from: data)
    }

    func fetchNotes() async throws -> [SingleNoteDTO] {
        let data = try await networking.get(path: FirebaseCollection.notes.getPathWithLocale())
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([SingleNoteDTO].self, from: data)
//        [
//            .init(value: .init(value: .c, type: .sharp, octave: .oct5), clef: .treble, title: "C flat"),
//            .init(value: .init(value: .c, type: .natural, octave: .middleC), clef: .treble, title: "C"),
//            .init(value: .init(value: .d, type: .flat, octave: .middleC), clef: .treble, title: "D flat"),
//            .init(value: .init(value: .d, type: .natural, octave: .middleC), clef: .treble, title: "D"),
//            .init(value: .init(value: .e, type: .flat, octave: .oct3), clef: .bass, title: "E flat"),
//            .init(value: .init(value: .f, type: .sharp, octave: .oct3), clef: .treble, title: "F sharp"),
//            .init(value: .init(value: .g, type: .flat, octave: .oct1), clef: .bass, title: "G flat"),
//            .init(value: .init(value: .g, type: .natural, octave: .oct5), clef: .treble, title: "G"),
//            .init(value: .init(value: .b, type: .flat, octave: .oct2), clef: .bass, title: "B flat"),
//            .init(value: .init(value: .b, type: .natural, octave: .oct3), clef: .bass, title: "B")
//        ]
    }

    func fetchChords() async throws -> [ChordDTO] {
        let data = try await networking.get(path: FirebaseCollection.chords.getPathWithLocale())
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([ChordDTO].self, from: data)
//        [
//            trebleBasicMajors(),
//            trebleBasicMinors(),
//            bassBasicMajors(),
//            bassBasicMinors()
//        ].flatMap { $0 }.shuffled()
    }

    func fetchHistoryQuestions() async throws -> [HistoryDTO] {
        let data = try await networking.get(path: FirebaseCollection.history.getPathWithLocale())
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode([HistoryDTO].self, from: data)
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
        id: "1",
        notes: [
            .init(value: .c, type: .natural, octave: .middleC),
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "C Major"
    )

    static let dMajor: ChordDTO = .init(
        id: "2",
        notes: [
            .init(value: .d, type: .natural, octave: .middleC),
            .init(value: .f, type: .sharp, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "D Major"
    )

    static let eMajor: ChordDTO = .init(
        id: "3",
        notes: [
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .sharp, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "E Major"
    )

    static let fMajor: ChordDTO = .init(
        id: "4",
        notes: [
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "F Major"
    )

    static let gMajor: ChordDTO = .init(
        id: "5",
        notes: [
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "G Major"
    )

    static let aMajor: ChordDTO = .init(
        id: "6",
        notes: [
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .sharp, octave: .oct5),
            .init(value: .e, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "A Major"
    )

    static let bMajor: ChordDTO = .init(
        id: "7",
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
        id: "8",
        notes: [
            .init(value: .c, type: .natural, octave: .middleC),
            .init(value: .e, type: .flat, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "C Minor"
    )

    static let dMinor: ChordDTO = .init(
        id: "9",
        notes: [
            .init(value: .d, type: .natural, octave: .middleC),
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "D Minor"
    )

    static let eMinor: ChordDTO = .init(
        id: "10",
        notes: [
            .init(value: .e, type: .natural, octave: .middleC),
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .natural, octave: .middleC)
        ],
        clef: .treble,
        title: "E Minor"
    )

    static let fMinor: ChordDTO = .init(
        id: "11",
        notes: [
            .init(value: .f, type: .natural, octave: .middleC),
            .init(value: .a, type: .flat, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "F Minor"
    )

    static let gMinor: ChordDTO = .init(
        id: "12",
        notes: [
            .init(value: .g, type: .natural, octave: .middleC),
            .init(value: .b, type: .flat, octave: .middleC),
            .init(value: .d, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "G Minor"
    )

    static let aMinor: ChordDTO = .init(
        id: "13",
        notes: [
            .init(value: .a, type: .natural, octave: .middleC),
            .init(value: .c, type: .natural, octave: .oct5),
            .init(value: .e, type: .natural, octave: .oct5)
        ],
        clef: .treble,
        title: "A Minor"
    )

    static let bMinor: ChordDTO = .init(
        id: "14",
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
        id: "15",
        notes: [
            .init(value: .c, type: .natural, octave: .oct3),
            .init(value: .e, type: .natural, octave: .oct3),
            .init(value: .g, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "C Major"
    )

    static let dBassMajor: ChordDTO = .init(
        id: "16",
        notes: [
            .init(value: .d, type: .natural, octave: .oct3),
            .init(value: .f, type: .sharp, octave: .oct3),
            .init(value: .a, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "D Major"
    )

    static let eBassMajor: ChordDTO = .init(
        id: "17",
        notes: [
            .init(value: .e, type: .natural, octave: .oct3),
            .init(value: .g, type: .sharp, octave: .oct3),
            .init(value: .b, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "E Major"
    )

    static let fBassMajor: ChordDTO = .init(
        id: "18",
        notes: [
            .init(value: .f, type: .natural, octave: .oct3),
            .init(value: .a, type: .natural, octave: .oct3),
            .init(value: .c, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "F Major"
    )

    static let gBassMajor: ChordDTO = .init(
        id: "19",
        notes: [
            .init(value: .g, type: .natural, octave: .oct3),
            .init(value: .b, type: .natural, octave: .oct3),
            .init(value: .d, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "G Major"
    )

    static let aBassMajor: ChordDTO = .init(
        id: "20",
        notes: [
            .init(value: .a, type: .natural, octave: .oct2),
            .init(value: .c, type: .sharp, octave: .oct3),
            .init(value: .e, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "A Major"
    )

    static let bBassMajor: ChordDTO = .init(
        id: "21",
        notes: [
            .init(value: .b, type: .natural, octave: .oct2),
            .init(value: .d, type: .sharp, octave: .oct3, extraSpaceForType: true),
            .init(value: .f, type: .sharp, octave: .oct3)
        ],
        clef: .bass,
        title: "B Major"
    )

    // MARK: - Bass basic Minors

    static let cBassMinor: ChordDTO = .init(
        id: "22",
        notes: [
            .init(value: .c, type: .natural, octave: .oct3),
            .init(value: .e, type: .flat, octave: .oct3),
            .init(value: .g, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "C Minor"
    )

    static let dBassMinor: ChordDTO = .init(
        id: "23",
        notes: [
            .init(value: .d, type: .natural, octave: .oct3),
            .init(value: .f, type: .natural, octave: .oct3),
            .init(value: .a, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "D Minor"
    )

    static let eBassMinor: ChordDTO = .init(
        id: "24",
        notes: [
            .init(value: .e, type: .natural, octave: .oct3),
            .init(value: .g, type: .natural, octave: .oct3),
            .init(value: .b, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "E Minor"
    )

    static let fBassMinor: ChordDTO = .init(
        id: "25",
        notes: [
            .init(value: .f, type: .natural, octave: .oct3),
            .init(value: .a, type: .flat, octave: .oct3),
            .init(value: .c, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "F Minor"
    )

    static let gBassMinor: ChordDTO = .init(
        id: "26",
        notes: [
            .init(value: .g, type: .natural, octave: .oct3),
            .init(value: .b, type: .flat, octave: .oct3),
            .init(value: .d, type: .natural, octave: .middleC)
        ],
        clef: .bass,
        title: "G Minor"
    )

    static let aBassMinor: ChordDTO = .init(
        id: "27",
        notes: [
            .init(value: .a, type: .natural, octave: .oct2),
            .init(value: .c, type: .natural, octave: .oct3),
            .init(value: .e, type: .natural, octave: .oct3)
        ],
        clef: .bass,
        title: "A Minor"
    )

    static let bBassMinor: ChordDTO = .init(
        id: "28",
        notes: [
            .init(value: .b, type: .natural, octave: .oct2),
            .init(value: .d, type: .natural, octave: .oct3),
            .init(value: .f, type: .sharp, octave: .oct3)
        ],
        clef: .bass,
        title: "B Minor"
    )
}
