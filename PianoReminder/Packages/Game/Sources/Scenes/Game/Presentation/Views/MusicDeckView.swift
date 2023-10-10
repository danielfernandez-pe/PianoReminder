//
//  MusicDeckView.swift
//
//
//  Created by Daniel Yopla on 09.10.2023.
//

import SwiftUI

struct MusicDeckView<ViewModel: GameViewModelType>: View {
    var viewModel: ViewModel
    let maxHeight: CGFloat

    @State private var newQuestion: Question?
    @State private var currentQuestion: Question?
    @State private var zIndex: CGFloat = 0

    @State private var topCardOffsetX: CGFloat = .zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxHeight: maxHeight)
                .addShadow()
                .offset(x: 0, y: 20)

            if let newQuestion {
                newQuestion.musicView
                    .padding(.large)
                    .frame(maxHeight: maxHeight)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .addShadow()
                    }
                    .offset(x: 0, y: 12)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .frame(maxHeight: maxHeight)
                    .addShadow()
                    .offset(x: 0, y: 12)
            }

            if let question = currentQuestion {
                question.musicView
                    .padding(.large)
                    .frame(maxHeight: maxHeight)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .addShadow()
                    }
                    .offset(x: topCardOffsetX, y: 0)
                    .rotationEffect(.degrees(Double(topCardOffsetX / 6)), anchor: .bottomLeading)
                    .zIndex(zIndex)
            }
        }
        .onAppear {
            currentQuestion = viewModel.question
        }
        .onChange(of: viewModel.question) { oldValue, newValue in
            guard oldValue != nil, newValue != nil else { return }

            newQuestion = newValue

            withAnimation(.easeInOut(duration: 0.2)) {
                topCardOffsetX = -500
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    zIndex = -3
                    topCardOffsetX = .zero
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                zIndex = 0
                newQuestion = nil
                currentQuestion = newValue
            }
        }
    }
}

#Preview {
    MusicDeckView<GameMockViewModel>(
        viewModel: GameMockViewModel(),
        maxHeight: 200
    )
    .padding()
}
