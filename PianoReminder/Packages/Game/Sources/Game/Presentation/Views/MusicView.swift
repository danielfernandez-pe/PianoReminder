//
//  MusicView.swift
//  
//
//  Created by Daniel Yopla on 13.06.2023.
//

import SwiftUI

// Just a wrapper to use it in Question protocol to render the view without knowing it's domain data
public struct MusicView: View {
    public enum MusicType {
        case chord(Chord)
        case note(SingleNote)
    }

    private let type: MusicType

    public init(type: MusicType) {
        self.type = type
    }

    public var body: some View {
        switch type {
        case .chord(let chord):
            ChordView(chord: chord)
        case .note(let note):
            NoteView(note: note)
        }
    }
}

