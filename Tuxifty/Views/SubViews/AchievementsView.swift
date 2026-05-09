//
//  AchievementsView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 09/04/2026.
//

import SwiftUI
import SwiftDraw

struct AchievementsView: View {
    @State private var searchQuery: String = "";
    var achievements: [Achievements42];
    
    var body: some View {
        let displayedAchievements = searchQuery.isEmpty
        ? achievements
        : achievements.filter { achievement in
            achievement.name
                .localizedCaseInsensitiveContains(searchQuery);
        }
        
        NavigationStack {
            List(displayedAchievements) { achievement in
                if let url = URL(string: getAchievementIcon(image: achievement.image)) {
                    SingleAchievementView(achievement: achievement, iconURL: url);
                } else {
                    SingleAchievementView(achievement: achievement, iconURL: nil);
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .searchable(text: $searchQuery, prompt: "Search achievements...")
            .navigationTitle("Achievements")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        )
    }
    
    func getAchievementIcon(image: String) -> String {
        let path = "https://cdn.intra.42.fr";
        let newPath = image.replacingOccurrences(of: "/uploads", with: path)

        return newPath;
    }
}

#Preview {
    AchievementsView(achievements: Achievements42.tabExample);
}
