//
//  Clef.swift
//  
//
//  Created by Daniel Yopla on 12.04.2023.
//

import Foundation

enum Clef: String {
    case treble
    case bass

    var height: CGFloat {
        switch self {
        case .treble:
            return 74  // 5 * 2 + 16 * 4
        case .bass:
            return 58
        }
    }
}
