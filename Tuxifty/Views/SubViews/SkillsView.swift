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

        VStack(alignment: .leading) {
            Text("Skills")
                .font(Font.largeTitle.bold())
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)

                TextField(
                    skills.isEmpty ? "No skills in this cursus" : "Search...",
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
            
            List(displayedSkills) { skill in
                SingleSkillView(
                    skill: skill,
                    linearGradient: selectedCursusIndex == 0
                    ? LinearGradient(colors: [.progressMainStart, .progressMainEnd], startPoint: .leading, endPoint: .trailing)
                    : LinearGradient(colors: [.progressAltStart, .progressAltEnd], startPoint: .leading, endPoint: .trailing),
                    color: selectedCursusIndex == 0
                    ? Color.blue
                    : Color.indigo
                )
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        )
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
        
        SkillsView(user: .example, selectedCursusIndex: 1)
    }
}
