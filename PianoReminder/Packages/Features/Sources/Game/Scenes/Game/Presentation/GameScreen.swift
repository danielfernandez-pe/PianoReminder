//
//  GameScreen.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import PianoUI
import UI

struct GameScreen<ViewModel: GameViewModelType>: View {
    var viewModel: ViewModel
    private let minDeckHeight: CGFloat = 200

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 48) {
                Group {
                    timer
                        .fixedSize(horizontal: false, vertical: true)

                    deckView(maxHeight: geometry.size.height * 0.2)
                }
                .padding(.horizontal, .medium)

                Spacer()

                optionsView
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.getQuestion()
        }
        .toolbar(.hidden)
        .background(Color.bgPrimary)
    }

    private func deckView(maxHeight: CGFloat) -> some View {
        CardsDeckView(
            viewModel: viewModel,
            maxHeight: max(minDeckHeight, maxHeight)
        )
    }

    private var optionsView: some View {
        BackgroundCircleView(backgroundColor: .bgSecondary) {
            options
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }

    private var options: some View {
        GeometryReader { geometry in
            if let question = viewModel.question {
                VStack(spacing: .small) {
                    Group {
                        option(question: question, optionIndex: 0)

                        option(question: question, optionIndex: 1)

                        option(question: question, optionIndex: 2)

                        option(question: question, optionIndex: 3)

                        Button("Skip") {
                            Task {
                                await viewModel.userTapOption(nil)
                            }
                        }
                        .scaledFont(.caption, fontWeight: .bold)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .foregroundStyle(Color.fgBlue)
                    }
                    .frame(maxWidth: geometry.size.width * 0.7)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var timer: some View {
        TimerView(viewModel: viewModel.timerViewModel)
    }

    private func option(question: QuestionUI, optionIndex: Int) -> some View {
        Button(question.options[optionIndex].title) {
            Task {
                await viewModel.userTapOption(question.options[optionIndex])
            }
        }
        .buttonStyle(
            buttonStyle(option: question.options[optionIndex], answer: viewModel.userAnswer)
        )
        .addShadow()
        .if(shouldShowInteraction(option: question.options[optionIndex], answer: viewModel.userAnswer)) { $0.showInteraction() }
    }

    private func buttonStyle(option: UserOptionUI,
                             answer: UserOptionUI?) -> MainButtonStyle<Icons.ButtonImage> {
        if let answer {
            if option == answer {
                return option.isAnswer ? .correctAnswer : .wrongAnswer
            }
        }

        return .game
    }

    private func shouldShowInteraction(option: UserOptionUI, answer: UserOptionUI?) -> Bool {
        if let answer {
            return option == answer
        }

        return false
    }
}

struct UserInteractionModifier: ViewModifier {
    @State private var showInteraction = false

    // This duration 0.2 + 0.2 should be the same as the one I'm using in GameViewModel for the Task.sleep
    func body(content: Content) -> some View {
        content
            .scaleEffect(showInteraction ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.2), value: showInteraction)
            .onAppear {
                showInteraction = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showInteraction = false
                }
            }
    }
}

extension View {
    public func showInteraction() -> some View {
        modifier(UserInteractionModifier())
    }
}

#Preview {
    GameScreen<GameMockViewModel>(
        viewModel: GameMockViewModel()
    )
}

final class GameMockViewModel: GameViewModelType {
    var title: String = "Which chord will you choose?"
    var question: QuestionUI? = .init(
        options: [
            .init(title: "C major", isAnswer: false),
            .init(title: "D major", isAnswer: false),
            .init(title: "F major", isAnswer: false),
            .init(title: "G major", isAnswer: false)
        ],
        questionViewType: .chord(.init(notes: [], clef: .bass)),
        category: .sightReading
    )
    var userAnswer: UserOptionUI?
    var currentPoints = 5

    var timerViewModel = TimerViewModel()

    func userTapOption(_ option: UserOptionUI?) async {
    }

    func getQuestion() {
    }

    func currentScreen() -> some View {
        EmptyView()
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 */
