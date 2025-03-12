//
//  TimerView.swift
//  Timer
//
//  Created by Holden Prine on 3/11/25.
//

import SwiftUI

struct TimerView: View {
    
    @State private var timeRemaining = 300
    
    var body: some View {
        Text("\(timeRemaining)")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    TimerView()
}
