//
//  Icons.swift
//
//
//  Created by Daniel Yopla on 10.10.2023.
//

import SwiftUI

public enum Icons {
    public enum Small {}

    public enum Medium: String {
        case check = "checkmark.circle"
        case cross = "x.circle"

        public var image: some View {
            Image(systemName: self.rawValue)
                .renderingMode(.template)
                .frame(size: .init(width: 24, height: 24))
        }
    }

    public enum Large {}
}
