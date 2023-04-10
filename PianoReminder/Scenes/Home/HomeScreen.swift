// 
//  HomeScreen.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import Networking
import Game

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        GameScreen(viewModel: .init())
    }
}

struct HomeScreenPreviews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: .init(networking: PreviewNetworking()))
    }
}

