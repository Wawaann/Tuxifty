//
//  AchievementsView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 09/04/2026.
//

import SwiftUI
import SwiftDraw

struct AchievementsView: View {
    
    let achievements: [Achievements42];
    var selectedCursusIndex: Int;
    @State private var searchQuery: String = "";
    
    var body: some View {
        let displayedAchievements = searchQuery.isEmpty
        ? achievements
        : achievements.filter { achievement in
            achievement.name
                .localizedCaseInsensitiveContains(searchQuery);
        }
        
        VStack(alignment: .leading) {
            Text("Achievements")
                .font(Font.largeTitle.bold())
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)

                TextField(
                    achievements.isEmpty ? "No achievements" : "Search...",
                    text: $searchQuery
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                Button {
                    searchQuery = ""
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
            List(displayedAchievements) { achievement in
                let color: Color = selectedCursusIndex == 0
                    ? Color(.progressMainStart)
                    : Color(.progressAltStart)
                if let url = URL(string: getAchievementIcon(image: achievement.image)) {
                    SingleAchievementView(achievement: achievement, iconURL: url, color: color);
                } else {
                    SingleAchievementView(achievement: achievement, iconURL: nil, color: color);
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
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
        AchievementsView(achievements: Achievements42.tabExample, selectedCursusIndex: 1)
    }
}
