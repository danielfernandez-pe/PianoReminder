//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine

public protocol GameViewModelInputs {
    func startTimer()
    func getQuestion()
    func userTapNoteOption(_ option: NoteQuestion.Option)
    func userTapChordOption(_ option: ChordQuestion.Option)
}

public protocol GameViewModelOutputs: ObservableObject {
    var timerViewModel: TimerViewModel { get }
    var noteQuestion: NoteQuestion? { get }
    var chordQuestion: ChordQuestion? { get }
}

public protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}

public final class GameViewModel: GameViewModelType {
    @Published public var noteQuestion: NoteQuestion?
    @Published public var chordQuestion: ChordQuestion?

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

    public func startTimer() {
        timerViewModel.start()
    }

    public func getQuestion() {
        switch userSettingsRepository.getGameType() {
        case .notes:
            noteQuestion = gameRepository.getNoteQuestion()
        case .chords:
            chordQuestion = gameRepository.getChordQuestion()
        case .notesAndChords:
            break // wtf?
        }
    }

    public func userTapNoteOption(_ option: NoteQuestion.Option) {
        if let noteQuestion {
            let isCorrect = option.value == noteQuestion.question
            print("user answer is correct? \(isCorrect)")
            getQuestion()
        }
    }

    public func userTapChordOption(_ option: ChordQuestion.Option) {
        if let chordQuestion {
            let isCorrect = option.value == chordQuestion.question
            print("user answer is correct? \(isCorrect)")
            getQuestion()
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
