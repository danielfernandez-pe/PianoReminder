//
//  GameManager.swift
//
//
//  Created by Daniel Yopla on 15.04.2024.
//

import Foundation

protocol GameManagerType {
    var correctAnsweredQuestions: [QuestionDOM] { get }

    func setup() async
    func getQuestion() async -> QuestionDOM
    func userAnsweredCorrectly()
    func userAnsweredWrong()
}

final class GameManager: GameManagerType {
    var correctAnsweredQuestions: [QuestionDOM] = []

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
            // TODO: get from database again but now using a predicate to avoid story questions (if the user has this setup) and isUsed doesnt matter
        }

        var nextQuestion = questions.removeFirst()
        currentQuestion = nextQuestion

        switch nextQuestion.questionType {
        case .story(let story):
            let options = story.storyOptions.map { UserOptionDOM(title: $0.value, isAnswer: $0.isAnswer) }.shuffled()
            nextQuestion.options = options
        case .chord, .note:
            var randomOptions = getRandomQuestions(relatedTo: nextQuestion).compactMap { UserOptionDOM(title: $0.questionTitle, isAnswer: false) }
            let correctOption = UserOptionDOM(title: nextQuestion.questionTitle, isAnswer: true)
            randomOptions.append(correctOption)
            nextQuestion.options = randomOptions.shuffled()
        }

        return nextQuestion
    }

    func userAnsweredCorrectly() {
        guard let currentQuestion else { return }
        correctAnsweredQuestions.append(currentQuestion)
    }

    func userAnsweredWrong() {
        guard let currentQuestion else { return }
        wrongAnsweredQuestions.append(currentQuestion)
    }

    private func getRandomQuestions(relatedTo question: QuestionDOM) -> [QuestionDOM] {
        do {
            var copy = try questions.filter(predicate(for: question))
            var result: [QuestionDOM] = []

            while result.count < 3 {
                guard let randomIndex = copy.indices.randomElement() else {
                    break
                }

                let possibleItem = copy[randomIndex]
                if result.firstIndex(where: { $0.questionTitle == possibleItem.questionTitle }) == nil {
                    result.append(possibleItem)
                    copy.remove(at: randomIndex)
                }
            }

            return result
        } catch {
            logger.error("Predicate for random questions failing \(error)")
            return []
        }
    }

    private func predicate(for originalQuestion: QuestionDOM) -> Predicate<QuestionDOM> {
        let randomQuestionsFilter: Predicate<QuestionDOM>
        let originalQuestionTitle = originalQuestion.questionTitle

        switch originalQuestion.questionType {
        case .chord:
            randomQuestionsFilter = #Predicate<QuestionDOM> { question in
                question.isChordQuestion && question.questionTitle != originalQuestionTitle
            }
        case .note:
            randomQuestionsFilter = #Predicate<QuestionDOM> { question in
                question.isNoteQuestion && question.questionTitle != originalQuestionTitle
            }
        case .story:
            randomQuestionsFilter = #Predicate<QuestionDOM> { question in
                question.isStoryQuestion && question.questionTitle != originalQuestionTitle
            }
        }

        return randomQuestionsFilter
    }
}
