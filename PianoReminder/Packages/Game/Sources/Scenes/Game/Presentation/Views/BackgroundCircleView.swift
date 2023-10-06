//
//  BackgroundCircleView.swift
//  
//
//  Created by Daniel Yopla on 01.10.2023.
//

import SwiftUI

struct BackgroundCircleView<Content: View>: View {
    private let backgroundColor: Color
    private let content: Content

    init(backgroundColor: Color,
         @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }

    var body: some View {
            content
                .frame(maxWidth: .infinity)
                .background {
                    ArchShape()
                        .fill(backgroundColor)
                }
    }
}

struct ArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
                path.move(to: CGPoint(x: 0, y: 0))
                path.addQuadCurve(to: CGPoint(x: rect.width, y: 0), control: CGPoint(x: rect.midX, y: -80)) // Adjust the control point and curve as needed
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                return path
    }
}

#Preview {
    BackgroundCircleView(backgroundColor: .green) {
        VStack {
            Button("Option 1") { print("") }
                .buttonStyle(.primary)
            Button("Option 2") { print("") }
                .buttonStyle(.primary)
            Button("Option 3") { print("") }
                .buttonStyle(.primary)
            Button("Option 4") { print("") }
                .buttonStyle(.primary)
        }
    }
}

