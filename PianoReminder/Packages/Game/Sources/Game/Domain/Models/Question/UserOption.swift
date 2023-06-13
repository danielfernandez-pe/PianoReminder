//
//  UserOption.swift
//  
//
//  Created by Daniel Yopla on 13.06.2023.
//

import Foundation

public struct UserOption: Identifiable, Equatable {
    public var id: String { title }

    let title: String
    let isAnswer: Bool
}
