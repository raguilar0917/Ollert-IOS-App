import SwiftUI

struct PomodoroTimerView: View {
    @State private var isRunning = false
    @State private var timeRemaining = 25 * 60 // 25 minutes
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(timeString(time: timeRemaining))
                .font(.system(size: 60))
                .padding()
            
            Button(action: {
                isRunning.toggle()
            }) {
                Text(isRunning ? "Pause" : "Start")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(isRunning ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onReceive(timer) { _ in
            if isRunning && timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        timeRemaining = 25 * 60
        isRunning = true
    }
    
    private func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
