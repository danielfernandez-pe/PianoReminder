//
//  TimerView.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel

    @State private var elapsedSeconds: TimeInterval = 0.0
    @State private var isTimerRunning = false

    private var timer: Timer? {
        if isTimerRunning {
            return Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if elapsedSeconds < viewModel.totalSeconds {
                    elapsedSeconds += 1.0
                } else {
                    isTimerRunning = false
                    viewModel.timerIsUp()
                }
            }
        }
        return nil
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(elapsedSeconds / viewModel.totalSeconds))
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1.0), value: elapsedSeconds)

            Text("\(Int(viewModel.totalSeconds - elapsedSeconds))s")
                .font(.footnote)
                .fontWeight(.bold)
        }
        .onAppear {
            if !isTimerRunning {
                isTimerRunning = true
                _ = timer
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init())
    }
}
