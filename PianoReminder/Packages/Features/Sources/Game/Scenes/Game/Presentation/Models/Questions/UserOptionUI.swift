//
//  UserOptionUI.swift
//  
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

struct UserOptionUI: Identifiable, Hashable {
    var id: String { title }
    let title: String
    let isAnswer: Bool
}
