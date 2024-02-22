//
//  StoryUI.swift
//
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct StoryUI: Hashable, Equatable {
    let titleQuestion: String
    let storyOptions: [Option]

    struct Option: Hashable {
        let value: String
        let isAnswer: Bool
    }
}
