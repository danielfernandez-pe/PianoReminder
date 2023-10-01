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

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: .xLarge) {
                timer
                    .fixedSize(horizontal: false, vertical: true)

                musicView(maxHeight: geometry.size.height * 0.25)

                optionsView
            }
        }
        .onAppear {
            viewModel.getQuestion()
        }
        .toolbar(.hidden)
        .padding(.horizontal, .medium)
    }

    @ViewBuilder
    private func musicView(maxHeight: CGFloat) -> some View {
        if let question = viewModel.question {
            question.musicView
                .frame(maxHeight: maxHeight)
                .padding(.large)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .shadow(radius: 16)
                }
        }
    }

    private var optionsView: some View {
        VStack(spacing: .large) {
            Text(viewModel.title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            options
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private var options: some View {
        Grid(verticalSpacing: .large) {
            if let question = viewModel.question {
                GridRow {
                    option(question: question, optionIndex: 0)
                    
                    option(question: question, optionIndex: 1)
                }

                GridRow {
                    option(question: question, optionIndex: 2)
                    
                    option(question: question, optionIndex: 3)
                }
            }
        }
    }

    private var timer: some View {
        TimerView(viewModel: viewModel.timerViewModel)
    }

    private func option(question: Question, optionIndex: Int) -> some View {
        Button(question.options[optionIndex].title) {
            Task {
                await viewModel.userTapOption(question.options[optionIndex])
            }
        }
        .buttonStyle(
            buttonStyle(option: question.options[optionIndex], answer: viewModel.userAnswer)
        )
        .if(shouldShowInteraction(option: question.options[optionIndex], answer: viewModel.userAnswer)) { $0.showInteraction() }
    }

    private func buttonStyle(option: UserOption,
                             answer: UserOption?) -> MainButtonStyle {
        if let answer {
            if option == answer {
                return option.isAnswer ? .correctAnswer : .wrongAnswer
            }
        }

        return .primary
    }

    private func shouldShowInteraction(option: UserOption, answer: UserOption?) -> Bool {
        if let answer {
            return option == answer
        }

        return false
    }
}

struct UserInteractionModifier: ViewModifier {
    @State private var showInteraction = false

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

struct GameScreenPreviews: PreviewProvider {
    static var previews: some View {
        GameScreen<MockViewModel>(
            viewModel: MockViewModel()
        )
    }

    private final class MockViewModel: GameViewModelType {
        var title: String = "Which chord will you choose?"
        var question: Question? = .init(
            options: [
                .init(title: "C major", isAnswer: false),
                .init(title: "D major", isAnswer: false),
                .init(title: "F major", isAnswer: false),
                .init(title: "G major", isAnswer: false)
            ],
            musicView: .init(
                type: .chord(InMemoryChords.cMajor.toModel())
            )
        )
        var userAnswer: UserOption?
        var currentPoints = 5

        var timerViewModel = TimerViewModel()

        func userTapOption(_ option: UserOption) async {
        }

        func getQuestion() {
        }

        func currentScreen() -> some View {
            EmptyView()
        }
    }
}

/* TODOs
 - C and F doesn't have a flat
 - Size is not correct so will overlap if not careful
 */

