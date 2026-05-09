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
            .background(.clear)
            .searchable(text: $searchQuery, prompt: "Search projects...")
            .navigationTitle("Projects")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white) // fond blanc de la carte
                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        )
    }
}

#Preview {
    ProjectsView(user: .example, selectedCursusIndex: 1)
}
