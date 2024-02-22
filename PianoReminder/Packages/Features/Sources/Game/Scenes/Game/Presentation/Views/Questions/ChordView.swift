//
//  ChordView.swift
//  
//
//  Created by Daniel Yopla on 23.04.2023.
//

import SwiftUI
import UI

struct ChordView: View {
    var chord: ChordUI

    @State private var linesSizes: [NoteUI: CGSize] = [:]
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

    private func noteLines(for note: ComposedNoteUI) -> some View {
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

    private func composedNote(for note: ComposedNoteUI) -> some View {
        ZStack {
            NoteTypeView(noteType: note.type)
                .offset(x: note.extraSpaceForType ?
                        (-Constants.spaceBetweenBars * 1.25) * 1.5 :
                        -Constants.spaceBetweenBars * 1.25)

            Ellipse()
                .fill(.black)
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

    private func shouldRenderLinesToTheBottom(for note: ComposedNoteUI) -> Bool {
        noteYPosition(for: note) > 0
    }

    private func noteYPosition(for note: ComposedNoteUI) -> CGFloat {
        switch chord.clef {
        case .bass:
            return bassPositioner
                .yPosition(for: note.value, in: note.octave)
        case .treble:
            return treblePositioner
                .yPosition(for: note.value, in: note.octave)
        }
    }

    private func range(for note: ComposedNoteUI) -> ClosedRange<Int>? {
        let yPosition = abs(noteYPosition(for: note))

        if yPosition > 1 {
            return (1...Int(((yPosition / Constants.spaceToMoveOneNote) / 2.0).rounded()))
        } else {
            return nil
        }
    }

    private func size(for note: NoteUI) -> CGSize {
        linesSizes[note] ?? .zero
    }
}

#Preview {
    VStack(spacing: 100) {
        ChordView(
            chord: .init(
                notes: [
                    .init(value: .a, type: .sharp, octave: .middleC, extraSpaceForType: false),
                    .init(value: .c, type: .sharp, octave: .oct5, extraSpaceForType: true),
                    .init(value: .e, type: .sharp, octave: .oct5, extraSpaceForType: false)
                ],
                clef: .treble
            )
        )

        ChordView(
            chord: .init(
                notes: [
                    .init(value: .c, type: .natural, octave: .oct3),
                    .init(value: .e, type: .natural, octave: .oct3),
                    .init(value: .g, type: .natural, octave: .oct3)
                ],
                clef: .bass
            )
        )
    }
    .background(.white)
}

/// Allows to safely access an array element by index
/// Usage: array[safe: 2]
extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
