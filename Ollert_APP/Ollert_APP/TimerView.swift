//
//  TimerView.swift
//  Ollert_APP
//
//  Created by Richard Aguilar on 5/20/23.
//

import SwiftUI

struct TimerView: View {
    @Binding var timerProgress: TimeInterval
    
    var body: some View {
        VStack {
            Text(timerText)
                .font(.title)
                .foregroundColor(isBreakTime ? .green : .red)
                .padding()
        }
    }
    
    private var timerText: String {
        let minutes = Int(timerProgress / 60)
        let seconds = Int(timerProgress) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private var isBreakTime: Bool {
        return timerProgress >= 25 * 60
    }
}
