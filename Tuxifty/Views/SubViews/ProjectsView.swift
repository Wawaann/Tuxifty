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

        NavigationStack {
            List(displayedProjects) { project in
                SingleProjectView(project: project)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .searchable(text: $searchQuery, prompt: "Search projects...")
            .navigationTitle("Projects")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .toolbarBackground(.hidden, for: .navigationBar)
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
