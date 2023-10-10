//
//  ScaledFont.swift
//
//
//  Created by Daniel Yopla on 30.09.2023.
//

import SwiftUI

extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var scalingType: ScalingType
    var fontWeight: UIFont.Weight

    var font: UIFont {
        UIFont.systemFont(ofSize: scaledValue, weight: fontWeight)
    }

    private var scaledValue: CGFloat {
        let defaultSize = scalingType.defaultFontSize
        return scalingType.metrics.scaledValue(for: defaultSize)
    }

    public init(scalingType: ScalingType, fontWeight: UIFont.Weight) {
        self.scalingType = scalingType
        self.fontWeight = fontWeight
    }

    func body(content: Content) -> some View {
        content
            .font(.init(uiFont: font))
    }
}

extension View {
    /// Font weights:
    /// ultralight (100), thin (200), light (300), regular (400),
    /// medium (500), semibold (600), bold (700), heavy (800), black (900)
    public func scaledFont(_ scalingType: ScalingType, fontWeight: UIFont.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(scalingType: scalingType, fontWeight: fontWeight))
    }
}
