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
        switch userSettingsRepository.getGameType() {
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
    public func userTapOption(_ option: UserOption) async {
        userAnswer = UserOption(title: option.title, isAnswer: option.isAnswer)
        await continueAfterUserTap()
    }

    @MainActor
    private func continueAfterUserTap() async {
        if userAnswer?.isAnswer == true {
            gameRepository.increasePoints()
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
        question = gameRepository.getQuestion(gameType: userSettingsRepository.getGameType())
    }

    private func setupTimer() {
        timerViewModel.timerFinished
            .sink { _ in
                print("Show overview screen")
            }
            .store(in: &cancellables)
    }
}
