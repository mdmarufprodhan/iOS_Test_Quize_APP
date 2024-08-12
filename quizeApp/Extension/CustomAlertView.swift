//
//  CustomAlertView.swift
//  quizeApp
//
//  Created by Maruf on 12/8/24.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showAlert: Bool
    var message: String
    var onYes: () -> Void
    var onNo: () -> Void
    
    var body: some View {
        ZStack {
            if showAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image("alert_img")
                    Text(message)
                        .bold()
                        .lineLimit(2)
                        //.font(.headline)
                        .padding(16)
                       // .multilineTextAlignment(.center)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            onNo()
                            showAlert = false
                        }) {
                            Text("No")
                                .foregroundColor(AppColors.mainBgColor)
                                .frame(width: 100, height: 40)
                                .background(AppColors.popUpColor)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            onYes()
                            showAlert = false
                        }) {
                            Text("Yes")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(AppColors.mainBgColor)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: 310, height: 268)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
            }
        }
    }
}

struct QuizeAlertCard: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                showAlert = true
            }
        }
        .overlay(
            CustomAlertView(
                showAlert: $showAlert,
                message: "Are you sure you want to start your quiz?",
                onYes: {
                    print("User pressed Yes")
                },
                onNo: {
                    print("User pressed No")
                }
            )
        )
    }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        QuizeAlertCard()
    }
}
