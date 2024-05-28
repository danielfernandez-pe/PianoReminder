//
//  HistoryUI.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct HistoryUI: Hashable, Equatable {
    let titleQuestion: String
    let historyOptions: [Option]

    struct Option: Hashable {
        let value: String
        let isAnswer: Bool
    }
}
