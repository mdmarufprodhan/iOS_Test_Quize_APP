//
//  QuizViewModel.swift
//  quizeApp
//
//  Created by Maruf on 12/8/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var selectedAnswer: Answer? = nil
    @Published var isAnswerCorrect: Bool? = nil
    @Published var showCorrectAnswer: Bool = false
    @Published var isQuizCompleted: Bool = false
    @Published var highScore: Int = 0
    
    var currentQuestion: Question? {
        if currentQuestionIndex < questions.count {
            return questions[currentQuestionIndex]
        }
        return nil
    }

    init() {
        loadQuizData()
        loadHighScore()
    }

     func loadQuizData() {
        guard let url = Bundle.main.url(forResource: "quizData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load JSON data.")
            return
        }
         print("Data:\(url)")
        
        if let quiz = parseQuiz(from: data) {
            self.questions = quiz.questions
        }
    }

    func submitAnswer(_ answer: Answer) {
          guard let currentQuestion = currentQuestion else { return }
          selectedAnswer = answer
          if answer.key == currentQuestion.correctAnswer {
              score += currentQuestion.score
              isAnswerCorrect = true
          } else {
              isAnswerCorrect = false
          }
      }

    func goToNextQuestion() {
          if currentQuestionIndex < questions.count - 1 {
              currentQuestionIndex += 1
              selectedAnswer = nil
              isAnswerCorrect = nil
              showCorrectAnswer = false
          } else {
              // End of quiz
              isQuizCompleted = true
              checkAndUpdateHighScore()
          }
      }
    
    private func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "highScore")
        let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "highScore") //
      
    }
    
    private func saveHighScore() {
        let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "highScore") //
        UserDefaults.standard.set(highScore, forKey: "highScore")
    }
    
    private func checkAndUpdateHighScore() {
        if score > highScore {
            highScore = score
            saveHighScore()
        }
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        highScore = 0
        selectedAnswer = nil
        isAnswerCorrect = nil
        showCorrectAnswer = false
        isQuizCompleted = false
        questions.shuffle()
    }
}
