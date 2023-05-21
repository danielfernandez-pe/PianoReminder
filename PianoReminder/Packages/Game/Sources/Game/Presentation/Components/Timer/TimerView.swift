//
//  TimerView.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    @State private var timeLeft = 60

    var body: some View {
        Text(String(timeLeft))
            .font(.headline)
            .onReceive(viewModel.timer) { _ in
                timeLeft -= 1

                if timeLeft <= 0 {
                    viewModel.timerIsUp()
                }
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init())
    }
}
