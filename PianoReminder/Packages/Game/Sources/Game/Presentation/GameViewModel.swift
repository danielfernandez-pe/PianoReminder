//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine

public protocol GameViewModelInputs {
    func userTapNoteOption(_ option: NoteQuestion.Option) async
    func userTapChordOption(_ option: ChordQuestion.Option) async
}

public protocol GameViewModelOutputs: ObservableObject {
    var noteQuestion: NoteQuestion? { get }
    var chordQuestion: ChordQuestion? { get }
    var userAnswer: UserAnswer? { get }

    var currentPoints: Int { get }
    var timerViewModel: TimerViewModel { get }
}

public protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}

public final class GameViewModel: GameViewModelType {
    @Published public var noteQuestion: NoteQuestion?
    @Published public var chordQuestion: ChordQuestion?
    @Published public var userAnswer: UserAnswer?

    public var currentPoints: Int { gameRepository.points }
    public let timerViewModel: TimerViewModel = .init()

    // MARK: - Dependencies

    private let gameRepository: any GameRepositoryType
    private let userSettingsRepository: any UserSettingsRepositoryType

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

    public init(gameRepository: any GameRepositoryType, userSettingsRepository: any UserSettingsRepositoryType) {
        self.gameRepository = gameRepository
        self.userSettingsRepository = userSettingsRepository
        setupTimer()
        getQuestion()
    }

    @MainActor
    public func userTapNoteOption(_ option: NoteQuestion.Option) async {
        guard let noteQuestion else { return }
        let isCorrect = option.value == noteQuestion.question
        userAnswer = UserAnswer(noteOption: option, chordOption: nil, isCorrect: isCorrect)
        await continueAfterUserTap()
    }

    @MainActor
    public func userTapChordOption(_ option: ChordQuestion.Option) async {
        guard let chordQuestion else { return }
        let isCorrect = option.value == chordQuestion.question
        userAnswer = UserAnswer(noteOption: nil, chordOption: option, isCorrect: isCorrect)
        await continueAfterUserTap()
    }

    @MainActor
    private func continueAfterUserTap() async {
        if userAnswer?.isCorrect == true {
            gameRepository.increasePoints()
        }

        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            getQuestion()
        } catch {
            getQuestion()
        }
    }

    private func getQuestion() {
        switch userSettingsRepository.getGameType() {
        case .notes:
            noteQuestion = gameRepository.getNoteQuestion()
        case .chords:
            chordQuestion = gameRepository.getChordQuestion()
        case .notesAndChords:
            break // wtf?
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
