//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import SwiftUI

protocol GameViewModelInputs {
    func userTapOption(_ option: UserOption) async
    func getQuestion()
}

protocol GameViewModelOutputs {
    var title: String { get }

    var question: Question? { get }
    var userAnswer: UserOption? { get }

    var currentPoints: Int { get }
    var timerViewModel: TimerViewModel { get }
}

protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}

@Observable final class GameViewModel: GameViewModelType {
    enum Route {
        case overview
    }

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

    var question: Question?
    var userAnswer: UserOption?
    var currentPoints: Int = 0

    let timerViewModel: TimerViewModel = .init()

    let routing = PassthroughSubject<Route, Never>()

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Dependencies

    private let getNoteQuestionUseCase: GetNoteQuestionUseCase
    private let getChordQuestionUseCase: GetChordQuestionUseCase
    private let getGameTypeUseCase: GetGameTypeUseCase

    init(getNoteQuestionUseCase: GetNoteQuestionUseCase,
         getChordQuestionUseCase: GetChordQuestionUseCase,
         getGameTypeUseCase: GetGameTypeUseCase) {
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
            try await Task.sleep(nanoseconds: 400_000_000)
            userAnswer = nil
            getQuestion()
        } catch {
            fatalError("this should never happen")
        }
    }

    private func setupTimer() {
        timerViewModel.timerFinished
            .map { _ in Route.overview }
            .subscribe(routing)
            .store(in: &cancellables)
    }
}
