//
//  TimerView.swift
//  Timer
//
//  Created by Holden Prine on 3/11/25.
//

import SwiftUI

struct TimerView: View {
    
    @State private var timeRemaining = 100
    @State private var timerRunning = false
    @State private var timer: Timer?
//    to handle state of arc
    @State private var arcProgress: CGFloat = 0.0
    @Environment(\.colorScheme) var colorScheme
    private let totalTime = 100
    private let strokeWidth: CGFloat = 18
    
//    for managing the initial time for the timer
    private let initialTime: Int = 100
    
    
    var body: some View {
        
        ZStack {
            Circle()
                .strokeBorder(lineWidth: strokeWidth)
                .frame(width: 300)
                .overlay {
                    Text(timeString(from: timeRemaining))
                        .font(.largeTitle)
                        .padding()
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
            
            TimerArc(progress: 1 - (Double(timeRemaining)/Double(totalTime)), lineWidth: strokeWidth).stroke(colorScheme == .dark ? Color.gray : Color.blue, lineWidth: 18).rotationEffect(.degrees(-90))
        }
        
        HStack {
            Button(action: startTimer) {
                Text(timerRunning ? "Stop" : "Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 120, height: 50)
                    .background(timerRunning ? Color.red : Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Button(action: resetTimer) {
                Text("Reset")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 120, height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
        .padding(.top, 60)
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        if timerRunning {
            timer?.invalidate()
            timer = nil
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    arcProgress = CGFloat(1 - (Double(timeRemaining) / Double(totalTime)))
                    print(arcProgress)
                } else {
                    timer?.invalidate()
                    timer = nil
                    timerRunning = false
                }
            }
        }
        timerRunning.toggle()
    }
    
    private func resetTimer() {
        timeRemaining = initialTime
        arcProgress = 0.0
        if timerRunning {
            timer?.invalidate()
            timer = nil
            timerRunning = false
        }
    }
}

#Preview {
    TimerView().preferredColorScheme(.dark)
}
