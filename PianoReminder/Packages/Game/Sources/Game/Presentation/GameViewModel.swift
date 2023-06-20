//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine

public protocol GameViewModelInputs {
    func userTapOption(_ option: UserOption) async
}

public protocol GameViewModelOutputs: ObservableObject {
    var title: String { get }

    var question: Question? { get }
    var userAnswer: UserOption? { get }

    var currentPoints: Int { get }
    var timerViewModel: TimerViewModel { get }
}

public protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}

public final class GameViewModel: GameViewModelType {
    public var title: String {
        switch getGameTypeUseCase.getGameType() {
        case .chords:
            return "Which chord is?"
        case .notes:
            return "Which note is?"
        case .notesAndChords:
            return "What will you choose?"
        }
    }

    @Published public var question: Question?
    @Published public var userAnswer: UserOption?
    @Published public var currentPoints: Int = 0

    public let timerViewModel: TimerViewModel = .init()

    // MARK: - Dependencies

    private let getNoteQuestionUseCase: GetNoteQuestionUseCase
    private let getChordQuestionUseCase: GetChordQuestionUseCase
    private let getGameTypeUseCase: GetGameTypeUseCase

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

    public init(gameRepository: any GameRepositoryType, userSettingsRepository: any UserSettingsRepositoryType) {
        getNoteQuestionUseCase = GetNoteQuestionUseCase(gameRepository: gameRepository)
        getChordQuestionUseCase = GetChordQuestionUseCase(gameRepository: gameRepository)
        getGameTypeUseCase = GetGameTypeUseCase(userSettingsRepository: userSettingsRepository)

        setupTimer()
        getQuestion()
    }

    @MainActor
    public func userTapOption(_ option: UserOption) async {
        userAnswer = UserOption(title: option.title, isAnswer: option.isAnswer)
        await continueAfterUserTap()
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

    private func getQuestion() {
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

    private func setupTimer() {
        timerViewModel.timerFinished
            .sink { _ in
                print("Show overview screen")
            }
            .store(in: &cancellables)
    }
}
