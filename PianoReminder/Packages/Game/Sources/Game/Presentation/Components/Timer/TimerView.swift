//
//  TimerView.swift
//  
//
//  Created by Daniel Yopla on 19.05.2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel

    var body: some View {
        Text(String(viewModel.timeLeft))
            .font(.headline)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init())
    }
}
