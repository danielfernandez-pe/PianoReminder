//
//  NoteTypeView.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import SwiftUI

struct NoteTypeView: View {
    var noteType: NoteType

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
        }
    }
}

struct NoteTypeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NoteTypeView(noteType: .flat)

            NoteTypeView(noteType: .sharp)
        }
    }
}
