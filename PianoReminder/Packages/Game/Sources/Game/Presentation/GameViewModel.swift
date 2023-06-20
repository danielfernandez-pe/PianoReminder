//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine

protocol GameViewModelInputs {
    func userTapOption(_ option: UserOption) async
    func getQuestion()
}

protocol GameViewModelOutputs: ObservableObject {
    var title: String { get }

    var question: Question? { get }
    var userAnswer: UserOption? { get }

    var currentPoints: Int { get }
    var timerViewModel: TimerViewModel { get }
}

protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}

final class GameViewModel: GameViewModelType {
    var title: String {
        switch getGameTypeUseCase.getGameType() {
        case .chords:
            return "Which chord is?"
        case .notes:
            return "Which note is?"
        case .notesAndChords:
            return "What will you choose?"
        }
    }

    @Published var question: Question?
    @Published var userAnswer: UserOption?
    @Published var currentPoints: Int = 0

    let timerViewModel: TimerViewModel = .init()

    // MARK: - Dependencies

    private let getNoteQuestionUseCase: GetNoteQuestionUseCase
    private let getChordQuestionUseCase: GetChordQuestionUseCase
    private let getGameTypeUseCase: GetGameTypeUseCase

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

    init(getNoteQuestionUseCase: GetNoteQuestionUseCase, getChordQuestionUseCase: GetChordQuestionUseCase, getGameTypeUseCase: GetGameTypeUseCase) {
        self.getNoteQuestionUseCase = getNoteQuestionUseCase
        self.getChordQuestionUseCase = getChordQuestionUseCase
        self.getGameTypeUseCase = getGameTypeUseCase

        setupTimer()
    }

    @MainActor
    func userTapOption(_ option: UserOption) async {
        userAnswer = UserOption(title: option.title, isAnswer: option.isAnswer)
        await continueAfterUserTap()
    }

    func getQuestion() {
        switch getGameTypeUseCase.getGameType() {
        case .notes:
            let noteQuestion = getNoteQuestionUseCase.getNoteQuestion()
            question = QuestionMapper.question(noteQuestion: noteQuestion)
        case .chords:
            let chordQuestion = getChordQuestionUseCase.getChordQuestion()
            question = QuestionMapper.question(chordQuestion: chordQuestion)
        case .notesAndChords:
            fatalError("Implement some random mechanism")
        }
    }

    @MainActor
    private func continueAfterUserTap() async {
        if userAnswer?.isAnswer == true {
            currentPoints += 1
        }

        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            userAnswer = nil
            getQuestion()
        } catch {
            fatalError("this should never happen")
        }
    }

    private func setupTimer() {
        timerViewModel.timerFinished
            .sink { _ in
                print("Show overview screen")
            }
            .store(in: &cancellables)
    }
}
