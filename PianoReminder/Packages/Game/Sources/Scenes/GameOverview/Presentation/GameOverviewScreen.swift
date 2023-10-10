//
//  GameOverviewScreen.swift
//  
//
//  Created by Daniel Yopla on 25.06.2023.
//

import SwiftUI
import PianoUI

struct GameOverviewScreen<ViewModel: GameOverviewViewModelType>: View {
    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: .medium) {
            Text("Hello world")

            Button("Back to home", action: { viewModel.backHomeTap() })
                .buttonStyle(.primary)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct GameOverviewScreenPreviews: PreviewProvider {
    static var previews: some View {
        GameOverviewScreen<MockViewModel>(
            viewModel: MockViewModel()
        )
    }

    private final class MockViewModel: GameOverviewViewModelType {
        func backHomeTap() {
        }
    }
}
