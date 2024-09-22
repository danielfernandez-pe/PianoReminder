//
//  GameViewModel+Protocols.swift
//  
//
//  Created by Daniel Yopla on 09.10.2023.
//

protocol GameViewModelInputs {
    func userTapOption(_ option: UserOptionUI?) async
    @MainActor func getQuestion()
}

protocol GameViewModelOutputs {
    var question: QuestionUI? { get }
    var userAnswer: UserOptionUI? { get }

    var currentPoints: Int { get }
    var timerViewModel: TimerViewModel { get }
}

protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}
