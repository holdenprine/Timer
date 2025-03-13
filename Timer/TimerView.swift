//
//  TimerView.swift
//  Timer
//
//  Created by Holden Prine on 3/11/25.
//

import SwiftUI

struct TimerView: View {
    
    @State private var timeRemaining: Int
    @State private var timerRunning = false
    @State private var timer: Timer?
//    To handle state of arc
    @State private var arcProgress: CGFloat = 0.0
//    Environment
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    private let totalTime: Int
    private let strokeWidth: CGFloat = 18
    
//    For managing the initial time for the timer
    private let initialTime: Int = 100
    
//    initializes passed TimeSelected data
    init(totalTime: Int) {
        self.totalTime = totalTime
        self._timeRemaining = State(initialValue: totalTime)
    }
    
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
            
            TimerArc(progress: arcProgress, lineWidth: strokeWidth)
                .stroke(colorScheme == .dark ? Color.orange : Color.blue, lineWidth: 18)
                .rotationEffect(.degrees(-90))
                .frame(width: 300)
                .animation(.easeInOut(duration: 0.5), value: arcProgress)
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
        
        Button(action: {
            dismiss()
        }) {
            Text("End Timer")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
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
                    
                    withAnimation(.easeInOut(duration: 1)) {
                        arcProgress = CGFloat(1 - (Double(timeRemaining) / Double(totalTime)))
                    }
                    
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
        withAnimation(.easeInOut(duration: 0.5)) {
            arcProgress = 0.0
        }
        if timerRunning {
            timer?.invalidate()
            timer = nil
            timerRunning = false
        }
    }
}

#Preview {
    TimerView(totalTime: 100).preferredColorScheme(.dark)
}
