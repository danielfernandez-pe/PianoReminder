//
//  NoteView.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI



struct NoteView: View {
    var note: Note
    var clef: Clef
    var type: NoteType
    var octave: Octave

    @State private var linesSize: CGSize = .zero

    private var shouldRenderLinesToTheBottom: Bool {
        noteYPosition > 0
    }

    private var range: ClosedRange<Int>? {
        /*
         The noteYPosition is where I will put the final note.
         Space to move one note basically will put a line
         for each note until the final position.
         However in the VStack that encapsulates this ForEach
         we put the spacing as Constants.spaceBetweenBars so
         I'll just render the main lines.
         Finally I divide this by 2 so I don't put more that
         the position of the final note. I rounded because
         I need one extra all the time.
         */
        let yPosition = abs(noteYPosition)
        if yPosition > 1 {
            return (1...Int(((yPosition / Constants.spaceToMoveOneNote) / 2.0).rounded()))
        } else {
            return nil
        }
    }

    var noteYPosition: CGFloat {
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

            noteLines

            composedNote
        }
    }

    private var noteLines: some View {
        VStack(spacing: Constants.spaceBetweenBars) {
            if let range {
                ForEach(range, id: \.self) { _ in
                    Rectangle()
                        .fill(.black)
                        .frame(
                            width: Constants.spaceBetweenBars * 1.75,
                            height: Constants.barHeight
                        )
                }
            }
        }
        .offset(y: linesSize.height / 2 - (Constants.barHeight / 2))
        .rotationEffect(.degrees(shouldRenderLinesToTheBottom ? .zero : 180))
        .readSize(onChange: { size in
            linesSize = size
        })
    }

    private var composedNote: some View {
        HStack(spacing: .xSmall) {
            NoteTypeView(noteType: type)

            Ellipse()
                .frame(
                    width: Constants.spaceBetweenBars * 1.25,
                    height: Constants.spaceBetweenBars
                )
                .overlay {
                    /*
                     if the noteYPosition divide by
                     spaceToMoveOneNote is even, then
                     you can be sure that the note is
                     placed on a main line
                     */
                    if (noteYPosition / Constants.spaceToMoveOneNote).remainder(dividingBy: 2) == 0 {
                        Rectangle()
                            .fill(.black)
                            .frame(
                                width: Constants.spaceBetweenBars * 1.75,
                                height: Constants.barHeight
                            )
                    }
                }
        }
        .offset(y: noteYPosition)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(
            note: .b,
            clef: .treble,
            type: .natural,
            octave: .middleC
        )
    }
}
