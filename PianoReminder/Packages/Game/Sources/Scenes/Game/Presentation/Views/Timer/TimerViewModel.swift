//
//  TimerViewModel.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation
import Combine
import Core

@Observable final class TimerViewModel {
    let totalSeconds: TimeInterval = 60
    let timerFinished = PassthroughSubject<Void, Never>()

    func timerIsUp() {
        timerFinished.sendAndComplete()
    }

    func pause() {
        
    }
}
