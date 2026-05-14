//
//  SingleAchievementView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 06/05/2026.
//

import SwiftUI

struct SingleAchievementView: View {
    
    let achievement: Achievements42;
    let iconURL: URL?;
    let color: Color;

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(achievement.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2);

                Text(achievement.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2);

                HStack(spacing: 8) {
                    Text(achievement.tier.capitalized)
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .foregroundStyle(color)
                        .background(color.opacity(0.12))
                        .clipShape(Capsule());

                    if let success = achievement.nbrOfSuccess {
                        Text("\(success) success")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.secondary);
                    }
                }
            }

            Spacer();

            if let iconURL {
                SVGImageView(url: iconURL);
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial.opacity(0.35))
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.blue.opacity(0.20), lineWidth: 1)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

#Preview {
    SingleAchievementView(achievement: .example, iconURL: URL(string: "https://cdn.intra.42.fr/achievement/image/41/SCO001.svg"), color: Color(.progressAltStart))
}
