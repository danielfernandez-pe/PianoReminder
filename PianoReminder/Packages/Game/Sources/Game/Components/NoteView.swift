//
//  NoteView.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI

enum Octave {
    case oct1
    case oct2
    case oct3
    case middleC
    case oct5
    case oct6
    case oct7
}

// swiftlint:disable identifier_name
enum Note {
    case c
    case d
    case e
    case f
    case g
    case a
    case b
}
// swiftlint:enable identifier_name

enum Clef: String {
    case treble
    case bass

    var height: CGFloat {
        switch self {
        case .treble:
            return 74  // 5 * 2 + 16 * 4
        case .bass:
            return 58
        }
    }
}

enum NoteType {
    case natural
    case flat
    case sharp
}

struct NoteView: View {
    var note: Note
    var clef: Clef
    var type: NoteType
    var octave: Octave

    var yPosition: CGFloat {
        switch clef {
        case .bass:
            return BassNotePositioner()
                .yPosition(for: note, in: octave)
        case .treble:
            return TrebleNotePositioner()
                .yPosition(for: note, in: octave)
        }
    }

    var body: some View {
        ZStack {
            StaffView(clef: clef)

            composedNote()
        }
        
    }

    private func composedNote() -> some View {
        HStack(spacing: .xSmall) {
            NoteTypeView(noteType: type)

            Ellipse()
                .frame(
                    width: Constants.spaceBetweenBars * 1.25,
                    height: Constants.spaceBetweenBars
                )
        }
        .offset(y: yPosition)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(
            note: .c,
            clef: .treble,
            type: .natural,
            octave: .middleC
        )
    }
}
