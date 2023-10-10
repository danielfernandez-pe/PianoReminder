//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import SwiftUI
import AVFoundation

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
    private var audioPlayer: AVAudioPlayer?

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
        setupSuccessSound()
    }

    @MainActor
    func userTapOption(_ option: UserOption?) async {
        if let option {
            userAnswer = UserOption(title: option.title, isAnswer: option.isAnswer)
        }

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
            playSuccessSound()
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

    private func setupSuccessSound() {
        guard let path = Bundle.module.path(forResource: "success.wav", ofType: nil) else { return }
        let url = URL(filePath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            // log
        }
    }

    private func playSuccessSound() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.audioPlayer?.play()
        }
    }
}
