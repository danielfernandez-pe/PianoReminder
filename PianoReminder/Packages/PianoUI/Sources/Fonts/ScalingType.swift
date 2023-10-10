//
//  ScalingType.swift
//
//
//  Created by Daniel Yopla on 30.09.2023.
//

import Foundation
import UIKit

public enum ScalingType {
    /// Size: 24
    case title
    /// Size: 16
    case body
    /// Size: 14
    case callout
    /// Size: 12
    case caption

    var defaultFontSize: CGFloat {
        size
    }

    var metrics: UIFontMetrics {
        UIFontMetrics(forTextStyle: textStyle)
    }

    var textStyle: UIFont.TextStyle {
        switch self {
        case .title:
            return .title1
        case .body:
            return .body
        case .callout:
            return .callout
        case .caption:
            return .caption1
        }
    }
    
    private var size: CGFloat {
        switch self {
        case .title:
            return 20
        case .body:
            return 16
        case .callout:
            return 14
        case .caption:
            return 12
        }
    }

    func font(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: metrics.scaledValue(for: defaultFontSize), weight: weight)
    }
}
