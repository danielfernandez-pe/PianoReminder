//
//  UserOption.swift
//  
//
//  Created by Daniel Yopla on 13.06.2023.
//

import Foundation

struct UserOption: Identifiable, Equatable {
    var id: String { title }

    let title: String
    let isAnswer: Bool
}
