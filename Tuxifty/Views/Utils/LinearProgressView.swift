//
//  LinearProgressView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 08/04/2026.
//

import SwiftUI

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var value: Double
    var shape: Shape

    var body: some View {
        shape.fill(.foreground.quaternary)
             .overlay(alignment: .leading) {
                 GeometryReader { proxy in
                     shape.fill(.tint)
                          .frame(width: proxy.size.width * value)
                 }
             }
             .clipShape(shape)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        LinearProgressView(value: 0.5, shape: Rectangle())
            .tint(.red)

        LinearProgressView(value: 8.06 / 20, shape: Capsule())
            .tint(Gradient(colors: [.purple, .blue]))

        LinearProgressView(value: 0.8, shape: RoundedRectangle(cornerRadius: 4))
            .tint(LinearGradient(colors: [.green, .cyan], startPoint: .leading, endPoint: .trailing))
    }
    .frame(height: 64)
    .padding()
}
