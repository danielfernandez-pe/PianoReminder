//
//  GameScreen.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI

public struct GameScreen: View {
    @ObservedObject var viewModel: GameViewModel

    public init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            NoteView(
                note: .a,
                clef: .treble,
                type: .sharp,
                octave: .middleC
            )

            Button("C Sharp") {
                print("c sharp tapped")
            }
        }
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
 - Use an image for SHARP
 */

