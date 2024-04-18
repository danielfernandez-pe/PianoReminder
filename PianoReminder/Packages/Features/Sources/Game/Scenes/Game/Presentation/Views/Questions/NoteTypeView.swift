//
//  NoteTypeView.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI
import UI

struct NoteTypeView: View {
    var noteType: NoteTypeUI

    var body: some View {
        switch noteType {
        case .natural:
            EmptyView()
        case .flat:
            Image("flat", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(height: Constants.spaceBetweenBars * 1.25)
                .offset(y: -3)
        case .sharp:
            // TODO: change for image like flat
            ZStack {
                HStack(spacing: .xSmall) {
                    Rectangle()
                        .frame(width: 3, height: Constants.spaceBetweenBars * 1.25)

                    Rectangle()
                        .frame(width: 3, height: Constants.spaceBetweenBars * 1.25)
                }

                VStack(spacing: .xSmall) {
                    Rectangle()
                        .frame(width: Constants.spaceBetweenBars, height: 3)

                    Rectangle()
                        .frame(width: Constants.spaceBetweenBars, height: 3)
                }
                .rotationEffect(.degrees(-10))
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    VStack {
        NoteTypeView(noteType: .flat)

        NoteTypeView(noteType: .sharp)
    }
    .background(.white)
}

