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

    public var body: some View {
        VStack(spacing: .medium) {
            if let question = viewModel.question {
                question.musicView
                    .frame(maxHeight: .infinity)
            }

            VStack(spacing: .small) {
                Text(String(viewModel.currentPoints))
                    .font(.body)
                    .fontWeight(.bold)

                Text(viewModel.title)
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
            if let question = viewModel.question {
                ForEach(question.options) { option in
                    Button(option.title) {
                        Task {
                            await viewModel.userTapOption(option)
                        }
                    }
                    .buttonStyle(
                        buttonStyle(option: option, answer: viewModel.userAnswer)
                    )
                    .if(shouldBounce(option: option, answer: viewModel.userAnswer)) {
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

    private func buttonStyle(option: UserOption,
                             answer: UserOption?) -> MainButtonStyle {
        if let answer {
            if option == answer {
                return option.isAnswer ? .correctAnswer : .wrongAnswer
            }
        }

        return .main
    }

    private func shouldBounce(option: UserOption,
                              answer: UserOption?) -> Bool {
        if let answer {
            if option == answer {
                return option.isAnswer
            }
        }

        return false
    }
}

struct GameScreenPreviews: PreviewProvider {
    static var previews: some View {
        GameScreen<MockViewModel>(
            viewModel: MockViewModel()
        )
    }

    private final class MockViewModel: GameViewModelType {
        var title: String = "Which note will you choose?"
        var question: Question?
        var userAnswer: UserOption?

        var currentPoints = 5
        var timerViewModel = TimerViewModel()

        func startTimer() {
        }

        func userTapOption(_ option: UserOption) async {
        }
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 */

