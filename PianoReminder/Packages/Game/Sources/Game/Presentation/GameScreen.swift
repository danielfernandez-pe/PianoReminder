//
//  GameScreen.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI

public struct GameScreen<ViewModel: GameViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
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
            .frame(maxHeight: .infinity)

            Text("Which note is?")
                .font(.title)

            options
                .frame(maxHeight: .infinity)
                .padding(.horizontal, .medium)
        }
        .overlay(
            timer,
            alignment: .topTrailing
        )
        .onAppear {
            viewModel.startTimer()
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

    private var timer: some View {
        TimerView(viewModel: viewModel.timerViewModel)
            .padding(.medium)
    }
}

extension ButtonStyle where Self == MainButtonStyle {
    public static var main: MainButtonStyle {
        MainButtonStyle(textColor: .white, backgroundColor: .blue)
    }
}

struct GameScreenPreviews: PreviewProvider {
    static var previews: some View {
        GameScreen<MockViewModel>(
            viewModel: MockViewModel()
        )
    }

    private final class MockViewModel: GameViewModelType {
        var timerViewModel = TimerViewModel()

        func startTimer() {
        }
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 - Little line in the middle of the note if it's not part of the main bars in the staff
 */

