//
//  GameManager.swift
//
//
//  Created by Daniel Yopla on 15.04.2024.
//

import Foundation

protocol GameManagerType {
    func setup() async
    func getQuestion() async -> QuestionDOM
    func userAnsweredWrong()
}

final class GameManager: GameManagerType {
    private var questions: [QuestionDOM] = []
    private var wrongAnsweredQuestions: [QuestionDOM] = []
    private var currentQuestion: QuestionDOM?

    private let getQuestionsUseCase: any GetQuestionsUseCaseType

    init(getQuestionsUseCase: any GetQuestionsUseCaseType) {
        self.getQuestionsUseCase = getQuestionsUseCase
    }

    func setup() async {
        questions = await getQuestionsUseCase.getQuestions()
    }

    func getQuestion() async -> QuestionDOM {
        if questions.isEmpty {
            questions.append(contentsOf: wrongAnsweredQuestions)
            // get from database again but now using a predicate to avoid story questions (if the user has this setup) and isUsed doesnt matter
        }

        var nextQuestion = questions.removeFirst()
        currentQuestion = nextQuestion

        var randomOptions = getRandomQuestions(relatedTo: nextQuestion).compactMap { UserOptionDOM(title: $0.questionTitle, isAnswer: false) }
        let correctOption = UserOptionDOM(title: nextQuestion.questionTitle, isAnswer: true)
        randomOptions.append(correctOption)

        nextQuestion.options = randomOptions.shuffled()
        return nextQuestion
    }

    func userAnsweredWrong() {
        guard let currentQuestion else { return }
        wrongAnsweredQuestions.append(currentQuestion)
    }

    private func getRandomQuestions(relatedTo question: QuestionDOM) -> [QuestionDOM] {
        do {
            var copy = try questions.filter(predicate(for: question))
            var result: [QuestionDOM] = []

            for _ in 0..<min(3, questions.count) {
                guard let randomIndex = copy.indices.randomElement() else {
                    break
                }

                result.append(copy[randomIndex])
                copy.remove(at: randomIndex)
            }

            return result
        } catch {
            logger.error("Predicate for random questions failing \(error)")
            return []
        }
    }

    private func predicate(for question: QuestionDOM) -> Predicate<QuestionDOM> {
        let randomQuestionsFilter: Predicate<QuestionDOM>

        switch question.questionType {
        case .chord:
            randomQuestionsFilter = #Predicate<QuestionDOM> { question in
                question.isChordQuestion
            }
        case .note:
            randomQuestionsFilter = #Predicate<QuestionDOM> { question in
                question.isNoteQuestion
            }
        case .story:
            randomQuestionsFilter = #Predicate<QuestionDOM> { question in
                question.isStoryQuestion
            }
        }

        return randomQuestionsFilter
    }
}
