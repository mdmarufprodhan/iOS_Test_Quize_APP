//
//  TestTimer.swift
//  quizeApp
//
//  Created by Maruf on 12/8/24.
//

import SwiftUI

struct CountdownView: View {
    @State private var timeRemaining: TimeInterval = 0
    private let endDate: Date
    
    init() {
        // Set the end date to August 15th at 11:59 PM
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2024
        components.month = 8
        components.day = 15
        components.hour = 23
        components.minute = 59
        
        endDate = calendar.date(from: components) ?? Date()
        
        // Calculate initial time remaining
        _timeRemaining = State(initialValue: endDate.timeIntervalSinceNow)
    }
    
    var body: some View {
        VStack {
            if timeRemaining > 0 {
                HStack {
                    hoursCardView(time:hours, hour: "Hour")
                    Spacer()
                    hoursCardView(time:minutes, hour: "Minute")
                    Spacer()
                    hoursCardView(time:seconds, hour: "Second")
                }
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    updateTimer()
                }
            } else {
                Text("Quiz Ended")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
        }
    }
    
    
    private var hours: String {
        String(format: "%02d", Int(timeRemaining) / 3600)
    }
    
    private var minutes: String {
        String(format: "%02d", (Int(timeRemaining) % 3600) / 60)
    }
    
    private var seconds: String {
        String(format: "%02d", Int(timeRemaining) % 60)
    }
    
    private func updateTimer() {
        let remaining = endDate.timeIntervalSinceNow
        if remaining > 0 {
            timeRemaining = remaining
        } else {
            timeRemaining = 0
        }
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
    
    struct CountdownView_Previews: PreviewProvider {
        static var previews: some View {
            CountdownView()
        }
    }
}

