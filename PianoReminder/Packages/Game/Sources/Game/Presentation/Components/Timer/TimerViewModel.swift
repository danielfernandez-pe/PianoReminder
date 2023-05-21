//
//  TimerViewModel.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation
import Combine

public final class TimerViewModel: ObservableObject {
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    let timerFinished = PassthroughSubject<Void, Never>()

    func timerIsUp() {
        timerFinished.send()
    }

    func pause() {
        timer.upstream.connect().cancel()
    }
}
