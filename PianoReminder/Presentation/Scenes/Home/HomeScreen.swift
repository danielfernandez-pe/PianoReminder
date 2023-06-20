// 
//  HomeScreen.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI
import PianoUI
import Game

struct HomeScreen<ViewModel: HomeViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            AsyncButton("Start game") {
                await viewModel.setupGame()
            }
            .buttonStyle(.main)
        }
        .navigationDestination(for: HomeRouter.Path.self) { path in
            switch path {
            case .game:
                gameScreen()
            }
        }
    }

    private func gameScreen() -> some View {
        let gameRouter = GameRouter(container: DIContainer.shared)
        return gameRouter.start()
    }
}

struct HomeScreenPreviews: PreviewProvider {
    static var previews: some View {
        HomeScreen<MockViewModel>(viewModel: .init())
    }

    final class MockViewModel: HomeViewModelType {
        var uiError: HomeViewModel.UIError?

        func setupGame() {
        }
    }
}
