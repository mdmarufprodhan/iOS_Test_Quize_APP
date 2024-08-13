//
//  AnswerPageView.swift
//  quizeApp
//
//  Created by Maruf on 11/8/24.
//

import SwiftUI

struct AnswerPageView: View {
    @State var cardAnswerClick = false
    @StateObject private var viewModel = QuizViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var timeRemaining = 10.0 // Set your desired quiz duration
    @State private var timerIsActive = false
    @State private var isAnswerDisabled = false
    @State private var timer: Timer?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("mainMenu_bg1"), Color("mainMenu_bg2")]),
                    startPoint: .top,
                    endPoint: .center
                ).ignoresSafeArea()
                
                ScrollView {
                    navBar
                    VStack {
                        HStack {
                            Text("Question \(viewModel.currentQuestionIndex)/\(viewModel.questions.count - 1 )")
                                .foregroundStyle(AppColors.mainBgColor)
                            Spacer()
                            Text("\(viewModel.score)")
                                .foregroundStyle(AppColors.mainBgColor)
                                .bold()
                            Image("gold")
                            
                        }
                        VStack (alignment: .center){
                            Image("jrfCard")
                        }
                        VStack(alignment:.leading,spacing:12){
                            if let question = viewModel.currentQuestion {
                                Text(question.question)
                                    .font(.system(size: 20))
                                    .padding(16)
                                    .lineLimit(2)
                                 timerCard
                                ForEach(question.answers) { answer in
                                    Button(action: {
                                        if !viewModel.isQuizCompleted{
                                            startTimer()
                                        }
                                        if !isAnswerDisabled {
                                            viewModel.submitAnswer(answer)
                                            isAnswerDisabled = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                viewModel.goToNextQuestion()
                                                isAnswerDisabled = false
                                            }
                                        }
                                    }, label: {
                                        HStack {
                                            Text("\(answer.key).")
                                                .foregroundStyle(.black)
                                                .bold()
                                            Text(answer.text)
                                                .foregroundStyle(.black)
                                                .bold()
                                            Spacer()
                                            
                                        }
                                        .padding(16)
                                        .frame(maxWidth:.infinity)
                                        .frame(height: 44)
                                        .border(.gray, width: 1)
                                        .background(viewModel.backgroundColor(for: answer))
                                        .cornerRadius(2)
                                        // .padding(16)
                                    })
                                }
                            }
                            
                            // timer
                        }
                        nextButton
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(.white)
                    .cornerRadius(12)
                    //.padding(16)
                }
                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarBackButtonHidden(true)
    }
    private var nextButton: some View {
        VStack {
            if viewModel.selectedAnswer != nil && viewModel.isQuizCompleted {
                Button(action: {
                    viewModel.goToNextQuestion()
                    //  isAnswerDisabled = false
                }, label: {
                    Text("next")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(AppColors.mainBgColor)
                        .cornerRadius(12)
                }).hidden()
                NavigationLink(destination: MainMenuView()) {
                    Text(viewModel.isQuizCompleted ? "Return to Main Menu": "Next")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(AppColors.mainBgColor)
                        .cornerRadius(12)
                }
                
            }
        }
    }
    private func questionCard(questionNumber: String,questions:String) -> some View {
        VStack {
            Button(action: {
                
            }, label: {
                HStack {
                    Text(questionNumber)
                    Text(questions)
                    Spacer()
                }
                .padding(16)
                .frame(height: 44)
                .border(.gray, width: 1)
                // .padding(16)
            })
            
        }
    }
    private var timerCard : some View {
        HStack {
            Text("Time:")
            // .font(.headline)
            //.padding(.bottom, 10)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .cornerRadius(4)
                
                Rectangle()
                    .frame(width: CGFloat(timeRemaining) * 10, height: 10)
                    .foregroundColor(AppColors.mainBgColor)
                    .cornerRadius(4)
                    .animation(.linear(duration: 1), value: timeRemaining)
            }
            .padding(.horizontal)
            Text("0.9 sec")
                .font(.system(size: 13))
            Spacer()
        }
        .padding()
      //  .onAppear(perform: startTimer)
    }
    private var navBar: some View {
        HStack {
            Button(action: {
                viewModel.goToNextQuestion()
                dismiss()
            }, label: {
                Image("backbtn")
            })
            
            Spacer()
            HStack {
                Image("timer_ic")
                Text("2.23")
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
    }
    
    func startTimer() {
        timer?.invalidate() // Invalidate any existing timer to prevent multiple timers running simultaneously
        timeRemaining = 10.0  // Reset the timer to its original state
        timerIsActive = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 && timerIsActive {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                timerIsActive = false
            }
        }
    }
}

#Preview {
    AnswerPageView()
}

extension QuizViewModel {
    func backgroundColor(for answer: Answer) -> Color {
        if let selectedAnswer = selectedAnswer, selectedAnswer.id == answer.id {
            return isAnswerCorrect == true ? .green : .red
        } else {
            return .white
        }
    }
}
