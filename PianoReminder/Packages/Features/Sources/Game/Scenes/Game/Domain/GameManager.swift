//
//  GameManager.swift
//
//
//  Created by Daniel Yopla on 15.04.2024.
//

import Foundation

final class GameManager {
    private var questions: [QuestionDOM] = []

    private let getQuestionsUseCase: GetQuestionsUseCase

    init(getQuestionsUseCase: GetQuestionsUseCase) {
        self.getQuestionsUseCase = getQuestionsUseCase
    }

    func setup() async {
        questions = await getQuestionsUseCase.getQuestions()
    }

    func getQuestion() async -> QuestionDOM {
        if questions.count < 10 {
            let newQuestions = await getQuestionsUseCase.getQuestions()
            questions.append(contentsOf: newQuestions)
        }

        var nextQuestion = questions.removeFirst()

        // randomly get options
        nextQuestion.options = [
            UserOptionDOM(title: "No", isAnswer: false),
            UserOptionDOM(title: "No", isAnswer: false),
            UserOptionDOM(title: "Yes", isAnswer: true),
            UserOptionDOM(title: "No", isAnswer: false)
        ]

        return nextQuestion
    }
}
