//
//  QuestionModel.swift
//  quizeApp
//
//  Created by Maruf on 12/8/24.
//

import Foundation

// MARK: - Answer Model
struct Answer: Identifiable {
    let id = UUID()
    let key: String
    let text: String
}

// MARK: - Question Model
struct Question: Identifiable {
    let id = UUID()
    let question: String
    let answers: [Answer]
    let questionImageUrl: String?
    let correctAnswer: String
    let score: Int
}

// MARK: - Quiz Model
struct Quiz {
    let questions: [Question]
}

// MARK: - Parsing JSON to Swift Model
func parseQuiz(from jsonData: Data) -> Quiz? {
    struct RawAnswer: Decodable {
        let A: String?
        let B: String?
        let C: String?
        let D: String?
    }

    struct RawQuestion: Decodable {
        let question: String
        let answers: RawAnswer
        let questionImageUrl: String?
        let correctAnswer: String
        let score: Int
    }

    struct RawQuiz: Decodable {
        let questions: [RawQuestion]
    }

    do {
        let rawQuiz = try JSONDecoder().decode(RawQuiz.self, from: jsonData)
        let questions = rawQuiz.questions.map { rawQuestion -> Question in
            var answers = [Answer]()
            
            if let aText = rawQuestion.answers.A {
                answers.append(Answer(key: "A", text: aText))
            }
            if let bText = rawQuestion.answers.B {
                answers.append(Answer(key: "B", text: bText))
            }
            if let cText = rawQuestion.answers.C {
                answers.append(Answer(key: "C", text: cText))
            }
            if let dText = rawQuestion.answers.D {
                answers.append(Answer(key: "D", text: dText))
            }
            
            return Question(
                question: rawQuestion.question,
                answers: answers.shuffled(),
                questionImageUrl: rawQuestion.questionImageUrl,
                correctAnswer: rawQuestion.correctAnswer,
                score: rawQuestion.score
            )
        }
        
        return Quiz(questions: questions)
    } catch {
        print("Failed to decode JSON: \(error)")
        return nil
    }
}
