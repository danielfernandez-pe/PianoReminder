//
//  GameOverviewScreen.swift
//  
//
//  Created by Daniel Yopla on 25.06.2023.
//

import SwiftUI
import PianoUI
import Charts

struct QuestionCategory: Identifiable {
    var id: String { name }
    let name: String
    let correctPercentage: Int
}

let categories: [QuestionCategory] = [
    .init(name: "Chords", correctPercentage: 80),
    .init(name: "Sound", correctPercentage: 40),
    .init(name: "Theory", correctPercentage: 20),
    .init(name: "History", correctPercentage: 90)
]

struct GameOverviewScreen<ViewModel: GameOverviewViewModelType>: View {
    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: .medium) {
            Chart(categories) { category in
                BarMark(
                    x: .value("Success %", category.correctPercentage),
                    y: .value("Category", category.name)
                )
            }
            .frame(height: 200)

            Button("Back to home", action: { viewModel.backHomeTap() })
                .buttonStyle(.primary)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    GameOverviewScreen<MockViewModel>(viewModel: MockViewModel())
}

private final class MockViewModel: GameOverviewViewModelType {
    func backHomeTap() {
    }
}
