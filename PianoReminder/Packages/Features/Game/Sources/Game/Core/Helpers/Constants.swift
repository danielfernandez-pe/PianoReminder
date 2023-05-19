//
//  Constants.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation

enum Constants {
    static let rectangleWidth: CGFloat = 2
    static let spaceBetweenBars: CGFloat = 16
    static let barHeight: CGFloat = 2

    static var spaceToMoveOneNote: CGFloat {
        (spaceBetweenBars + barHeight) / 2
    }
}
