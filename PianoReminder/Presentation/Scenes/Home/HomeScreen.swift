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
        .fullScreenCover(isPresented: $viewModel.isGamePresented) {
            viewModel.gameStartScreen()
        }
    }
}

struct HomeScreenPreviews: PreviewProvider {
    static var previews: some View {
        HomeScreen<MockViewModel>(viewModel: .init())
    }

    final class MockViewModel: HomeViewModelType {
        var uiError: HomeViewModel.UIError?
        var isGamePresented: Bool = false

        func setupGame() {
        }

        func gameStartScreen() -> some View {
            EmptyView()
        }
    }
}
