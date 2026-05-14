//
//  ProjectsView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 08/04/2026.
//

import SwiftUI

struct ProjectsView: View {
    var user: User
    var selectedCursusIndex: Int;
    @State private var searchQuery: String = "";

    var body: some View {
        let projects = user.projects

        let cursusProjects = projects.filter { project in
            project.cursusIds.contains(user.cursus[selectedCursusIndex].cursus.id)
        }

        let displayedProjects = searchQuery.isEmpty
            ? cursusProjects
            : cursusProjects.filter { project in
                project.project.name.localizedCaseInsensitiveContains(searchQuery)
            }

        VStack(alignment: .leading) {
            Text("Projects")
                .font(Font.largeTitle.bold())
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)

                TextField(
                    cursusProjects.isEmpty ? "No project in this cursus" : "Search...",
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

            
            List(displayedProjects) { project in
                SingleProjectView(
                    project: project,
                    color: selectedCursusIndex == 0
                        ? Color(.progressMainStart)
                        : Color(.progressAltStart),
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
        
        ProjectsView(user: .example, selectedCursusIndex: 1)
    }
}
