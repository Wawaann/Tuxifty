//
//  BackgroundView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 11/05/2026.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color(.base)

            RadialGradient(
                colors: [
                    Color.radialTopLeading.opacity(0.35),
                    Color.radialTopLeading.opacity(0.0)
                ],
                center: .topLeading,
                startRadius: 20,
                endRadius: 320
            )

            RadialGradient(
                colors: [
                    Color.radialTrailing.opacity(0.30),
                    Color.radialTrailing.opacity(0.0)
                ],
                center: .trailing,
                startRadius: 10,
                endRadius: 280
            )

            RadialGradient(
                colors: [
                    Color.radialBottom.opacity(0.25),
                    Color.radialBottom.opacity(0.0)
                ],
                center: .bottom,
                startRadius: 30,
                endRadius: 300
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
