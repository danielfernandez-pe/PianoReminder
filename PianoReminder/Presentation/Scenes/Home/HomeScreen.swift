// 
//  HomeScreen.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI

struct HomeScreen<ViewModel: HomeViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Button("Start game") {
                viewModel.setupGame()
            }
            .buttonStyle(.main)
        }
    }
}

struct HomeScreenPreviews: PreviewProvider {
    static var previews: some View {
        HomeScreen<MockViewModel>(viewModel: .init())
    }

    final class MockViewModel: HomeViewModelType {
        var homeError: HomeViewModel.HomeError?

        func setupGame() {
        }
    }
}
