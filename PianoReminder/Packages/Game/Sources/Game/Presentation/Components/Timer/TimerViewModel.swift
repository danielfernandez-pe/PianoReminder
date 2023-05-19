//
//  TimerViewModel.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import Foundation
import Combine

final class TimerViewModel: ObservableObject {
    @Published var timeLeft: Int = 10

    var timerFinished = PassthroughSubject<Void, Never>()

    private var cancellable: AnyCancellable?

    func start() {
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.timeLeft -= 1

                if self.timeLeft <= 0 {
                    self.timerFinished.send()
                }
            }
    }

    func pause() {
        cancellable = nil
    }

    func reset() {
        cancellable = nil
        timeLeft = 60
        start()
    }
}
