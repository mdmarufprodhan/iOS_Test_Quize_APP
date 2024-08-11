//
//  MainMenuView.swift
//  quizeApp
//
//  Created by Maruf on 10/8/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color("mainMenu_bg1"), Color("mainMenu_bg2")]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    VStack(alignment:.leading,spacing:12) {
                        Spacer()
                        Spacer()
                        headerView
                            .padding(.top,32)
                            .padding(16)
                        HStack{
                            Image("highScore")
                                .padding(.top,16)
                                .overlay {
                                    VStack(alignment:.center) {
                                        Text("500")
                                            .font(.system(size: 32))
                                            .bold()
                                            .foregroundStyle(.red)
                                            .fontWeight(.bold)
                                        Text("High Scroe")
                                            .font(.system(size:12))
                                    }
                                }
                            Spacer()
                            Image("coin_img")
                        }
                        VStack(alignment:.leading,spacing:4){
                            Text("JRF Sunday’s")
                                .font(.system(size: 32))
                                .foregroundStyle(.white)
                                .bold()
                            Text("Supper Quiz")
                                .font(.system(size: 48))
                                .foregroundStyle(.white)
                                .bold()
                            Text("Play Super Quiz & earn 500 coin")
                                .font(.system(size: 13))
                                .foregroundStyle(.white)
                        }
                        Spacer()
                      //  .padding(16)
                       quizeCard
                    }
                   // .padding(16)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    private var headerView : some View {
        HStack {
            Image("header_ic")
                .resizable()
                .frame(width: 24,height: 24)
            Spacer()
            Image("notification_ic")
        }
    }
    
    private var  quizeCard: some View {
        VStack(alignment:.leading,spacing:12){
            Text("Tosay’s Quiz on")
                .font(.system(size: 13))
            Text("General Knowledge")
                .font(.system(size: 20))
                .foregroundColor(AppColors.mainBgColor)
                .bold()
           // Spacer()
            VStack (alignment:.leading,spacing:12){
                Text("The Quize ends in")
                HStack {
                    hoursCardView(time: "2", hour: "Hour")
                    Spacer()
                    hoursCardView(time: "30", hour: "Minute")
                    Spacer()
                    hoursCardView(time: "50", hour: "Second")
                }
                NavigationLink {
                    AnswerPageView()
                } label: {
                    Text("Play Quiz Now")
                        .foregroundStyle(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height:56)
                        .background(AppColors.mainBgColor)
                        .cornerRadius(12)
                }
            }
            Spacer()
          
        }
        .padding(16)
        .frame(maxWidth:.infinity,alignment: .leading)
        .frame(height: 350)
        .background(.white)
        .cornerRadius(25, corners: [.topLeft, .topRight])
    }
    
    private func hoursCardView(time:String, hour:String) -> some View {
        Rectangle()
            .fill(AppColors.cardColor) // Set t
            .frame(width: 96,height:57)
            .cornerRadius(4)
            .overlay {
                VStack {
                    Text(time)
                        .font(.system(size: 20))
                        .bold()
                    Text(hour)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
            }
    }
    
}

#Preview {
    MainMenuView()
}
