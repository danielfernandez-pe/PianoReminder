//
//  GameScreen.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI

public struct GameScreen: View {
    @ObservedObject var viewModel: GameViewModel

    public init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
//            ChordView(
//                notes: [
//                    .init(value: .a, type: .natural, octave: .oct3),
//                    .init(value: .e, type: .natural, octave: .middleC),
//                    .init(value: .g, type: .natural, octave: .middleC)
//                ],
//                clef: .treble
//            )
//            .frame(maxHeight: .infinity)

            NoteView(
                note: .b,
                clef: .treble,
                type: .natural,
                octave: .middleC
            )
//            .frame(maxHeight: .infinity)

            Text("Which note is?")
                .font(.title)

            options
                .frame(maxHeight: .infinity)
                .padding(.horizontal, .medium)
        }
    }

    private var options: some View {
        VStack(spacing: .medium) {
            Button("C Sharp") {
                print("c sharp tapped")
            }
            .buttonStyle(.main)

            Button("C Sharp") {
                print("c sharp tapped")
            }
            .buttonStyle(.main)

            Button("C Sharp") {
                print("c sharp tapped")
            }
            .buttonStyle(.main)

            Button("C Sharp") {
                print("c sharp tapped")
            }
            .buttonStyle(.main)
        }
    }
}

extension ButtonStyle where Self == MainButtonStyle {
    public static var main: MainButtonStyle {
        MainButtonStyle(textColor: .white, backgroundColor: .blue)
    }
}

struct GameScreenPreviews: PreviewProvider {
    static var previews: some View {
        GameScreen(
            viewModel: .init()
        )
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 - Little line in the middle of the note if it's not part of the main bars in the staff
 */

