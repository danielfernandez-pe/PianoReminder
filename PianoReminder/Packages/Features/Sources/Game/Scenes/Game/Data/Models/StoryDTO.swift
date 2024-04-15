//
//  StoryDTO.swift
//
//
//  Created by Daniel Yopla on 19.02.2024.
//

import Foundation

struct StoryDTO: Codable {
    let titleQuestion: String
    let storyOptions: [Option]
    var category: CategoryDTO = CategoryDTO.story

    struct Option: Codable {
        let value: String
        let isAnswer: Bool
    }
}
