//
//  ChordView.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import SwiftUI
import UI

struct ChordView: View {
    var chord: ChordNote

    @State private var linesSizes: [Note: CGSize] = [:]
    private let bassPositioner = BassNotePositioner()
    private let treblePositioner = TrebleNotePositioner()

    var body: some View {
        ZStack {
            StaffView(clef: chord.clef)

            ForEach(chord.notes, id: \.self) { note in
                noteLines(for: note)
            }

            ForEach(chord.notes, id: \.self) { note in
                composedNote(for: note)
            }
        }
    }

    private func noteLines(for note: ComposedNote) -> some View {
        VStack(spacing: Constants.spaceBetweenBars) {
            if let range = range(for: note) {
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
        .offset(y: size(for: note.value).height / 2 - (Constants.barHeight / 2))
        .rotationEffect(.degrees(shouldRenderLinesToTheBottom(for: note) ? .zero : 180))
        .readSize(onChange: { size in
            linesSizes[note.value] = size
        })
    }

    private func composedNote(for note: ComposedNote) -> some View {
        HStack(spacing: .xSmall) {
            NoteTypeView(noteType: note.type)

            Ellipse()
                .frame(
                    width: Constants.spaceBetweenBars * 1.25,
                    height: Constants.spaceBetweenBars
                )
                .overlay {
                    if (noteYPosition(for: note) / Constants.spaceToMoveOneNote).remainder(dividingBy: 2) == 0 {
                        Rectangle()
                            .fill(.black)
                            .frame(
                                width: Constants.spaceBetweenBars * 1.75,
                                height: Constants.barHeight
                            )
                    }
                }
        }
        .offset(y: noteYPosition(for: note))
    }

    private func shouldRenderLinesToTheBottom(for note: ComposedNote) -> Bool {
        noteYPosition(for: note) > 0
    }

    private func noteYPosition(for note: ComposedNote) -> CGFloat {
        switch chord.clef {
        case .bass:
            return bassPositioner
                .yPosition(for: note.value, in: note.octave)
        case .treble:
            return treblePositioner
                .yPosition(for: note.value, in: note.octave)
        }
    }

    private func range(for note: ComposedNote) -> ClosedRange<Int>? {
        let yPosition = abs(noteYPosition(for: note))

        if yPosition > 1 {
            return (1...Int(((yPosition / Constants.spaceToMoveOneNote) / 2.0).rounded()))
        } else {
            return nil
        }
    }

    private func size(for note: Note) -> CGSize {
        linesSizes[note] ?? .zero
    }
}

struct ChordView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 100) {
            ChordView(
                chord: .init(
                    notes: [
                        .init(value: .a, type: .natural, octave: .oct3),
                        .init(value: .e, type: .natural, octave: .middleC),
                        .init(value: .g, type: .natural, octave: .middleC)
                    ],
                    clef: .treble
                )
            )

            ChordView(
                chord: .init(
                    notes: [
                        .init(value: .b, type: .natural, octave: .middleC),
                        .init(value: .f, type: .natural, octave: .oct5),
                        .init(value: .a, type: .natural, octave: .oct5)
                    ],
                    clef: .treble
                )
            )
        }
    }
}
