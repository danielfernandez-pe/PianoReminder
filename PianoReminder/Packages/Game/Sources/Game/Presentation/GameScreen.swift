//
//  GameScreen.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import PianoUI

public struct GameScreen<ViewModel: GameViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var questionTitle: String {
        if viewModel.chordQuestion != nil {
            return "Which chord is?"
        }

        if viewModel.chordQuestion != nil {
            return "Whic note is?"
        }

        return "What will you choose?"
    }

    public var body: some View {
        VStack {
            if let chordQuestion = viewModel.chordQuestion {
                ChordView(chord: chordQuestion.question)
                    .frame(maxHeight: .infinity)
                    .background(.debug)
            }

            if let noteQuestion = viewModel.noteQuestion {
                NoteView(note: noteQuestion.question)
                    .frame(maxHeight: .infinity)
                    .background(.debug)
            }

            Text(questionTitle)
                .font(.title)
                .background(.debug)

            options
                .frame(maxHeight: .infinity)
                .padding(.horizontal, .medium)
                .background(.debug)
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
            if let chordQuestion = viewModel.chordQuestion {
                ForEach(chordQuestion.options) { option in
                    Button(option.value.title) {
                        viewModel.userTapChordOption(option)
                    }
                    .buttonStyle(.main)
                }
            }

            if let noteQuestion = viewModel.noteQuestion {
                ForEach(noteQuestion.options) { option in
                    Button(option.value.title) {
                        viewModel.userTapNoteOption(option)
                    }
                    .buttonStyle(.main)
                }
            }
        }
    }

    private var timer: some View {
        TimerView(viewModel: viewModel.timerViewModel)
            .padding(.medium)
            .background(.debug)
    }
}

struct GameScreenPreviews: PreviewProvider {
    static var previews: some View {
        GameScreen<MockViewModel>(
            viewModel: MockViewModel()
        )
    }

    private final class MockViewModel: GameViewModelType {
        var noteQuestion: NoteQuestion?
        var chordQuestion: ChordQuestion?
        var timerViewModel = TimerViewModel()

        func getQuestion() {
        }

        func startTimer() {
        }

        func userTapNoteOption(_ option: NoteQuestion.Option) {
        }

        func userTapChordOption(_ option: ChordQuestion.Option) {
        }
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 - Little line in the middle of the note if it's not part of the main bars in the staff
 */

