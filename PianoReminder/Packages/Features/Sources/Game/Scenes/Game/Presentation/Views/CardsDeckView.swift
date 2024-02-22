//
//  MusicDeckView.swift
//
//
//  Created by Daniel Yopla on 09.10.2023.
//

import SwiftUI

fileprivate enum Padding {
    static var yOffset: CGFloat = 12
}

struct CardsDeckView<ViewModel: GameViewModelType>: View {
    var viewModel: ViewModel
    let maxHeight: CGFloat

    @State private var newQuestion: QuestionUI?
    @State private var currentQuestion: QuestionUI?
    @State private var zIndex: CGFloat = 0

    @State private var topCardOffsetX: CGFloat = .zero
    // This animation is to simulate the middle card going up as the new on top card
    @State private var finalAnimation = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxHeight: maxHeight)
                .padding(.horizontal, Padding.yOffset * 2)
                .addShadow()
                .offset(x: 0, y: Padding.yOffset * 2)

            if let newQuestion {
                QuestionView(type: newQuestion.questionViewType)
                    .padding(.large)
                    .frame(maxHeight: maxHeight)
                    .padding(.horizontal, finalAnimation ? 0 : Padding.yOffset)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .addShadow()
                    }
                    .offset(x: 0, y: finalAnimation ? 0 : Padding.yOffset)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .frame(maxHeight: maxHeight)
                    .padding(.horizontal, Padding.yOffset)
                    .addShadow()
                    .offset(x: 0, y: Padding.yOffset)
            }

            if let question = currentQuestion {
                QuestionView(type: question.questionViewType)
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
        .onChange(of: viewModel.question) { _, newValue in
            guard newValue != nil else { return }

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
                
                withAnimation(.linear(duration: 0.1)) {
                    finalAnimation = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                zIndex = 0
                newQuestion = nil
                currentQuestion = newValue
                finalAnimation = false
            }
            
            
        }
    }
}

#Preview {
    CardsDeckView<GameMockViewModel>(
        viewModel: GameMockViewModel(),
        maxHeight: 200
    )
    .padding()
}
