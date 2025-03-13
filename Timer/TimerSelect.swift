//
//  TimerSelect.swift
//  Timer
//
//  Created by Holden Prine on 3/12/25.
//
import SwiftUI

struct TimerSelect: View {
    @State private var selectedHours = 0
    @State private var selectedMinutes = 1
    @State private var selectedSeconds = 0
    @State private var navigateToTimer = false

    var body: some View {
        VStack {
            HStack {
//                Hours
                Picker(selection: $selectedHours, label: Text("Hours")) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                .clipped()
                
                Text(":")
                
//                Minutes
                Picker(selection: $selectedMinutes, label: Text("Minutes")) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                .clipped()
                
                Text(":")
                
//                Seconds
                Picker(selection: $selectedSeconds, label: Text("Seconds")) {
                    ForEach(0..<60, id: \.self) {second in
                        Text("\(second)").tag(second)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                .clipped()
            }
            .frame(height: 150)
            
            NavigationLink(destination: TimerView(totalTime: totalTimeInSeconds())) {
                Text("Start Timer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    
    private func totalTimeInSeconds() -> Int {
        return(selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
    }
}

#Preview {
    TimerSelect()
}
