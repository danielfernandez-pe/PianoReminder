//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine

public protocol GameViewModelInputs {
    func startTimer()
}

public protocol GameViewModelOutputs: ObservableObject {
    var timerViewModel: TimerViewModel { get }
}

public protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}

public final class GameViewModel: GameViewModelType {
    public let timerViewModel: TimerViewModel = .init()
    private var cancellables = Set<AnyCancellable>()

    public init() {
        setupTimer()
    }

    public func startTimer() {
        timerViewModel.start()
    }

    private func setupTimer() {
        timerViewModel.timerFinished
            .sink { _ in
                print("Show overview screen")
            }
            .store(in: &cancellables)
    }
}
