//
//  MusicDeckView.swift
//
//
//  Created by Daniel Yopla on 09.10.2023.
//

import SwiftUI

struct MusicDeckView: View {
    let musicView: MusicView
    let maxHeight: CGFloat
    @State private var topCardOffsetX: CGFloat = .zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxHeight: maxHeight)
                .addShadow()
                .offset(x: 0, y: 20)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxHeight: maxHeight)
                .addShadow()
                .offset(x: 0, y: 12)

            musicView
                .padding(.large)
                .frame(maxHeight: maxHeight)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .addShadow()
                }
                .offset(x: topCardOffsetX, y: 0)
                .rotationEffect(.degrees(Double(topCardOffsetX / 6)), anchor: .bottomLeading)
        }
    }
}

#Preview {
    MusicDeckView(
        musicView: .init(
            type: .chord(InMemoryChords.cMajor.toModel())
        ),
        maxHeight: 200
    )
    .padding()
}
