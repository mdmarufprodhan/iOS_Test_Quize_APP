//
//  AnswerPageView.swift
//  quizeApp
//
//  Created by Maruf on 11/8/24.
//

import SwiftUI

struct AnswerPageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var timeRemaining = 10.0 // Set your desired quiz duration
        @State private var timerIsActive = true
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
                            Text("Question 2/20")
                                .foregroundStyle(AppColors.mainBgColor)
                            Spacer()
                            Text("50")
                                .foregroundStyle(AppColors.mainBgColor)
                                .bold()
                            Image("gold")
                            
                        }
                        VStack (alignment: .center){
                            Image("jrfCard")
                        }
                        VStack(alignment:.leading,spacing: 0){
                            Text("What is the name of this card in the JRF?")
                                .lineLimit(2)
                            timer
                           // timer
                        }
                        questionCard(questionNumber: "A", questions: "JRF Black Card")
                        questionCard(questionNumber: "B", questions: "JRF Black Card")
                        questionCard(questionNumber: "C", questions: "JRF Black Card")
                        questionCard(questionNumber: "D", questions: "JRF Black Card")
                        
                        nextButton
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(.white)
                    .cornerRadius(12)
                    .padding(16)
                }
                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarBackButtonHidden(true)
    }
    private var nextButton: some View {
        VStack {
            Button(action: {
                
            }, label: {
               Text("next")
                    .foregroundStyle(.white)
                    .bold()
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(AppColors.mainBgColor)
                    .cornerRadius(12)
            })
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
    private var timer : some View {
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
            Spacer()
        }
        .padding()
        .onAppear(perform: startTimer)
    }
    private var navBar: some View {
        HStack {
            Button(action: {
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
