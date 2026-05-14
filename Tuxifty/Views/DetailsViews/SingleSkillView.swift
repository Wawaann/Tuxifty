//
//  SingleSkillView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 06/05/2026.
//

import SwiftUI

struct SingleSkillView: View {
    let skill: Skill42;
    let linearGradient: LinearGradient;
    let color: Color;

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text(skill.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2);

                Spacer();

                Text("Lvl \(formattedLevel(skill.level))")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .foregroundStyle(color)
                    .background(color.opacity(0.12))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(color.opacity(0.28), lineWidth: 1)
                    );
            }

            LinearProgressView(value: progressValue(for: skill.level), shape: Capsule())
                .frame(height: 8)
                .tint(linearGradient);
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
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }

    private func formattedLevel(_ level: Double) -> String {
        String(format: "%.2f", level);
    }

    private func progressValue(for level: Double) -> Double {
        min(max(level / 20.0, 0.0), 1.0);
    }
}

#Preview {
    SingleSkillView(
        skill: Skill42.example,
        linearGradient: LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing),
        color: Color.blue
    )
}
