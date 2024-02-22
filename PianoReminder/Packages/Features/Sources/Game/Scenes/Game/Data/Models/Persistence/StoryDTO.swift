//
//  StoryDTO.swift
//
//
//  Created by Daniel Yopla on 19.02.2024.
//

import Foundation
import SwiftData

@Model
class StoryDTO {
    let titleQuestion: String
    let storyOptions: [Option]

    struct Option: Codable {
        let value: String
        let isAnswer: Bool
    }

    init(titleQuestion: String, storyOptions: [Option]) {
        self.titleQuestion = titleQuestion
        self.storyOptions = storyOptions
    }
}
