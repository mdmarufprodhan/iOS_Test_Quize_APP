//
//  MainMenuView.swift
//  quizeApp
//
//  Created by Maruf on 10/8/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("mainMenu_bg1"), Color("mainMenu_bg2")]),
                    startPoint: .top,
                    endPoint: .center
                )
                VStack(alignment:.leading) {
                    headerView
                        .padding(32)
                    HStack{
                        Image("highScore")
                            .padding(.top,32)
                            .padding()
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
                            .padding(.bottom,32)
                    }
                    VStack(alignment:.leading,spacing: 16){
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
                    .padding(16)
                    VStack{
                     Text("Hello")
                    }
                    .frame(maxWidth:.infinity)
                    .frame(maxHeight:.infinity)
                    .background(.white)
                    .cornerRadius(30)

                }
               // .padding(16)
            }
            .edgesIgnoringSafeArea(.all)
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
    
}

#Preview {
    MainMenuView()
}
