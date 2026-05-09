//
//  SkillsView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 10/04/2026.
//

import SwiftUI

struct SkillsView: View {
    var user: User;
    var selectedCursusIndex: Int;
    @State private var searchQuery: String = "";

    var body: some View {
        let safeIndex = user.cursus.indices.contains(selectedCursusIndex) ? selectedCursusIndex : 0;
        let skills = user.cursus[safeIndex].skills;
        let displayedSkills = searchQuery.isEmpty
            ? skills
            : skills.filter { skill in
                skill.name.localizedCaseInsensitiveContains(searchQuery);
            };

        NavigationStack {
            List(displayedSkills) { skill in
                SingleSkillView(
                    skill: skill,
                    linearGradient: selectedCursusIndex == 0
                    ? LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                    : LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing),
                    color: selectedCursusIndex == 0
                    ? Color.blue
                    : Color.indigo
                )
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .searchable(text: $searchQuery, prompt: "Search skills...")
            .navigationTitle("Skills")
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
}

#Preview {
    SkillsView(user: .example, selectedCursusIndex: 1)
}
