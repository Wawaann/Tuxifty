//
//  CustomTabBar.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 08/05/2026.
//

import SwiftUI

struct CustomTabBar: View {
    
    var color: Color;
    @Binding var selectedTab: Int;
    @Namespace private var tabAniation;

    let tabs: [(label: String, icon: String)] = [
        ("Projects", "list.clipboard"),
        ("Skills", "star"),
        ("Achievements", "trophy")
    ]

    var body: some View {
        HStack {
            ForEach(tabs.indices, id: \.self) { index in
                Spacer()
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 20))
                        Text(tabs[index].label)
                            .font(.caption2)
                    }
                    .frame(minWidth: 70)
                    .foregroundStyle(selectedTab == index ? color : .gray)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background {
                        if selectedTab == index {
                            Capsule()
                                .fill(color.opacity(0.12))
                                .matchedGeometryEffect(id: "TAB_HIGHLIGHT", in: tabAniation)
                        } else {
                            Capsule().fill(Color.clear)
                        }
                    }
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 99, style: .continuous)
                .fill(.ultraThinMaterial.opacity(0.35))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 99, style: .continuous)
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        )
        .padding(.horizontal, 10)
    }
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var selectedTab: Int = 0;
    
    var body: some View {
        ZStack {
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
            CustomTabBar(color: Color(.progressAltEnd), selectedTab: $selectedTab)
        }
    }
}
