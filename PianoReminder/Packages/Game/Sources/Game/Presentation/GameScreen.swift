//
//  GameScreen.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import PianoUI
import UI

public struct GameScreen<ViewModel: GameViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var backgroundColor: Color = .white

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var questionTitle: String {
        if viewModel.chordQuestion != nil {
            return "Which chord is?"
        }

        if viewModel.noteQuestion != nil {
            return "Which note is?"
        }

        return "What will you choose?"
    }

    public var body: some View {
        VStack(spacing: .medium) {
            if let chordQuestion = viewModel.chordQuestion {
                ChordView(chord: chordQuestion.question)
                    .frame(maxHeight: .infinity)
            }

            if let noteQuestion = viewModel.noteQuestion {
                NoteView(note: noteQuestion.question)
                    .frame(maxHeight: .infinity)
            }

            VStack(spacing: .small) {
                Text(String(viewModel.currentPoints))
                    .font(.body)
                    .fontWeight(.bold)

                Text(questionTitle)
                    .font(.title)
            }

            options
                .frame(maxHeight: .infinity)
                .padding(.horizontal, .medium)
        }
        .overlay(
            timer,
            alignment: .topTrailing
        )
    }

    private var options: some View {
        VStack(spacing: .medium) {
            if let chordQuestion = viewModel.chordQuestion {
                ForEach(chordQuestion.options) { option in
                    Button(option.value.title) {
                        Task {
                            await viewModel.userTapChordOption(option)
                        }
                    }
                    .buttonStyle(
                        buttonStyle(chordOption: option, userAnswer: viewModel.userAnswer)
                    )
                    .bounce(shouldBounce(chordOption: option, userAnswer: viewModel.userAnswer))
                }
            }

            if let noteQuestion = viewModel.noteQuestion {
                ForEach(noteQuestion.options) { option in
                    Button(option.value.title) {
                        Task {
                            await viewModel.userTapNoteOption(option)
                        }
                    }
                    .buttonStyle(
                        buttonStyle(noteOption: option, userAnswer: viewModel.userAnswer)
                    )
                    .if(shouldBounce(noteOption: option, userAnswer: viewModel.userAnswer)) {
                        $0.bounce()
                    }
                }
            }
        }
    }

    private var timer: some View {
        TimerView(viewModel: viewModel.timerViewModel)
            .padding(.medium)
    }

    // swiftlint:disable function_default_parameter_at_end
    private func buttonStyle(chordOption: ChordQuestion.Option? = nil,
                             noteOption: NoteQuestion.Option? = nil,
                             userAnswer: UserAnswer?) -> MainButtonStyle {
        if let chordOption {
            if let userChordOption = userAnswer?.chordOption,
               chordOption.value == userChordOption.value {
                return userChordOption.isAnswer ? .correctAnswer : .wrongAnswer
            }
        }

        if let noteOption {
            if let userNoteOption = userAnswer?.noteOption,
               noteOption.value == userNoteOption.value {
                return userNoteOption.isAnswer ? .correctAnswer : .wrongAnswer
            }
        }

        return .main
    }

    private func shouldBounce(chordOption: ChordQuestion.Option? = nil,
                              noteOption: NoteQuestion.Option? = nil,
                              userAnswer: UserAnswer?) -> Bool {
        if let chordOption {
            if let userChordOption = userAnswer?.chordOption,
               chordOption.value == userChordOption.value {
                return userChordOption.isAnswer
            }
        }

        if let noteOption {
            if let userNoteOption = userAnswer?.noteOption,
               noteOption.value == userNoteOption.value {
                return userNoteOption.isAnswer
            }
        }

        return false
    }
    // swiftlint:enable function_default_parameter_at_end
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
        var userAnswer: UserAnswer?

        var currentPoints = 5
        var timerViewModel = TimerViewModel()

        func startTimer() {
        }

        func userTapNoteOption(_ option: NoteQuestion.Option) async {
        }

        func userTapChordOption(_ option: ChordQuestion.Option) async {
        }
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 */

