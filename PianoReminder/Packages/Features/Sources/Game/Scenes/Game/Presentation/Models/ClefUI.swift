//
//  ClefUI.swift
//  
//
//  Created by Daniel Yopla on 21.02.2024.
//

import Foundation

enum ClefUI: String, Codable {
    case treble
    case bass

    var height: CGFloat {
        switch self {
        case .treble:
            return 74  // 5 (bars) * 2 (height of bar) + 16 (margin) * 4 (for spaces between the 5 bars)
        case .bass:
            return 58
        }
    }
}
