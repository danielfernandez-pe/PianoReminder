//
//  StoryDOM.swift
//
//
//  Created by Daniel Yopla on 19.02.2024.
//

import Foundation

// TODO: Extract Option to some Generic Option question type where value is something else
struct StoryDOM {
    let titleQuestion: String
    let storyOptions: [Option]

    struct Option {
        let value: String
        let isAnswer: Bool
    }
}
