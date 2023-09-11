//
//  TimerViewModel.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation
import Combine
import Core

final class TimerViewModel: ObservableObject {
    let totalSeconds: TimeInterval = 10
    let timerFinished = PassthroughSubject<Void, Never>()

    func timerIsUp() {
        timerFinished.sendAndComplete()
    }

    func pause() {
        
    }
}
