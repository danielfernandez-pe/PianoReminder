//
//  TimerView.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import SwiftUI
import PianoUI

struct TimerView: View {
    var viewModel: TimerViewModel
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

    private var remainingSeconds: Int {
        Int(viewModel.totalSeconds - elapsedSeconds)
    }

    var body: some View {
//            Circle()
//                .trim(from: 0, to: CGFloat(elapsedSeconds / viewModel.totalSeconds))
//                .stroke(Color.blue, lineWidth: 10)
//                .frame(width: 40, height: 40)
//                .rotationEffect(.degrees(-90))
//                .animation(.linear(duration: 1.0), value: elapsedSeconds)
        VStack(spacing: .small) {
            HStack {
                Spacer()

                Label("\(remainingSeconds)s", systemImage: "deskclock.fill")
                    .scaledFont(.caption, fontWeight: .bold)
                    .foregroundStyle(Color.fgYellowDark)
                    .padding(.small)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.fgYellowLight)
                    }
            }

            timeSlider
        }
        .onAppear {
            if !isTimerRunning {
                isTimerRunning = true
                _ = timer
            }
        }
    }

    private var timeSlider: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.fgPurple.opacity(0.25))
                    .frame(maxWidth: .infinity, maxHeight: .small)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.fgPurple)
                    .frame(maxWidth: timeSliderWidth(totalWidth: geometry.size.width), maxHeight: .small)
                    .animation(.linear(duration: 1.0), value: elapsedSeconds)
            }
        }
    }

    private func timeSliderWidth(totalWidth: CGFloat) -> CGFloat {
        let remainingSeconds = viewModel.totalSeconds - elapsedSeconds
        return (remainingSeconds * totalWidth) / viewModel.totalSeconds
    }
}

#Preview {
    TimerView(viewModel: .init())
}
