//
//  CustomTabBar.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 08/05/2026.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    let tabs: [(label: String, icon: String)] = [
        ("Projects", "clipboard"),
        ("Skills", "brain"),
        ("Achievements", "book")
    ]

    var body: some View {
        HStack {
            ForEach(tabs.indices, id: \.self) { index in
                Spacer()
                Button {
                    selectedTab = index
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 22))
                        Text(tabs[index].label)
                            .font(.caption2)
                    }
                    .foregroundStyle(selectedTab == index ? .blue : .gray)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        selectedTab == index
                            ? Capsule().fill(Color.blue.opacity(0.12))
                            : Capsule().fill(Color.clear)
                    )
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 8) // safe area iPhone
        .padding(.top, 8)
        .background(
            // Carte blanche avec blur léger pour imiter la TabBar native
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -2)
        )
        .padding(.horizontal, 10)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0))
}
