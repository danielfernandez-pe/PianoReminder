//
//  GameViewModel+Protocols.swift
//  
//
//  Created by Daniel Yopla on 09.10.2023.
//

protocol GameViewModelInputs {
    func userTapOption(_ option: UserOption?) async
    func getQuestion()
}

protocol GameViewModelOutputs {
    var title: String { get }

    var question: Question? { get }
    var userAnswer: UserOption? { get }

    var currentPoints: Int { get }
    var timerViewModel: TimerViewModel { get }
}

protocol GameViewModelType: GameViewModelInputs, GameViewModelOutputs {}
