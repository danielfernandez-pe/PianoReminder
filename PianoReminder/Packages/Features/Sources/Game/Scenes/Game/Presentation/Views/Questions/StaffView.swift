//
//  StaffView.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI

struct StaffView: View {
    var clef: ClefUI

    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: Constants.spaceBetweenBars) {
                ForEach((1...5), id: \.self) { _ in
                    Rectangle()
                        .fill(.black)
                        .frame(height: Constants.barHeight)
                }
            }

            clefImage
        }
    }

    private var clefImage: some View {
        Image(clef.rawValue, bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(height: clef.height)
    }
}

#Preview {
    VStack(spacing: 64) {
        StaffView(clef: .treble)

        StaffView(clef: .bass)
    }
}
