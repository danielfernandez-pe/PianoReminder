// 
//  HomeViewModel.swift
//  PianoReminder
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Combine
import Networking

final class HomeViewModel: ObservableObject {
    @Published var title = "Hello world"
    let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }
}
