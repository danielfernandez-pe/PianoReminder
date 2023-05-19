//
//  GameViewModel.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine

public final class GameViewModel: ObservableObject {
    let timerViewModel: TimerViewModel = .init()
    private var cancellables = Set<AnyCancellable>()

    public init() {
        setupTimer()
    }

    func startTimer() {
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
