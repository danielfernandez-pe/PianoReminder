//
//  HistoryDTO.swift
//
//
//  Created by Daniel Yopla on 19.02.2024.
//

import Foundation

struct HistoryDTO: Codable {
    let titleQuestion: String
    let historyOptions: [Option]
    var category: CategoryDTO = CategoryDTO.history

    struct Option: Codable {
        let value: String
        let isAnswer: Bool
    }

    init(titleQuestion: String, historyOptions: [Option]) {
        self.titleQuestion = titleQuestion
        self.historyOptions = historyOptions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.titleQuestion = try container.decode(String.self, forKey: .titleQuestion)
        self.historyOptions = try container.decode([HistoryDTO.Option].self, forKey: .historyOptions)
        self.category = try container.decodeIfPresent(CategoryDTO.self, forKey: .category) ?? .sightReading
        
    }

    private enum CodingKeys: String, CodingKey {
        case titleQuestion, historyOptions, category
    }
}