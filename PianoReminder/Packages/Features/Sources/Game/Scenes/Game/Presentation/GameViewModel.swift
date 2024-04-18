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

    var question: QuestionUI?
    var userAnswer: UserOptionUI?
    var currentPoints: Int = 0

    let timerViewModel: TimerViewModel = .init()

    let routing = PassthroughSubject<Route, Never>()

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    private var successPlayer: AVAudioPlayer?
    private var errorPlayer: AVAudioPlayer?
    
    var deleteME = true

    // MARK: - Dependencies

    private let gameManager: any GameManagerType

    init(gameManager: any GameManagerType) {
        self.gameManager = gameManager

        setupTimer()
        setupSoundPlayers()
    }

    @MainActor
    func userTapOption(_ option: UserOptionUI?) async {
        if let option {
            userAnswer = UserOptionUI(title: option.title, isAnswer: option.isAnswer)
        }

        await continueAfterUserTap()
    }

    @MainActor
    func getQuestion() {
        Task {
            // TODO: This setup should be in a separate scene: GameLoading
            if deleteME {
                deleteME = false
                await gameManager.setup()
            }

            let questionDOM = await gameManager.getQuestion()
            question = UIMapper.question(questionDOM)
        }
    }

    @MainActor
    private func continueAfterUserTap() async {
        let userPickedCorrectAnswer = userAnswer?.isAnswer == true

        if userPickedCorrectAnswer {
            currentPoints += 1
            playSuccessSound()
        } else {
            let userPickedWrongAnswer = userAnswer?.isAnswer == false

            if userPickedWrongAnswer {
                playErrorSound()
            }

            gameManager.userAnsweredWrong()
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

    private func setupSoundPlayers() {
        guard let successPath = Bundle.module.path(forResource: "success.wav", ofType: nil),
              let errorPath = Bundle.module.path(forResource: "error.wav", ofType: nil) else { return }
        let successUrl = URL(filePath: successPath)
        let errorUrl = URL(filePath: errorPath)

        do {
            successPlayer = try AVAudioPlayer(contentsOf: successUrl)
            errorPlayer = try AVAudioPlayer(contentsOf: errorUrl)
        } catch {
            // log
        }
    }

    private func playSuccessSound() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.successPlayer?.play()
        }
    }

    private func playErrorSound() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.errorPlayer?.play()
        }
    }
}
