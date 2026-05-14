//
//  LevelBarView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 08/04/2026.
//

import SwiftUI

struct LevelBarView: View {
    @State var user: User;
    @State private var showGradeDialog = false;
    @Binding var cursusIndex: Int;

    var body: some View {
        Group {
            if !user.cursus.isEmpty {
                let cursus = user.cursus
                HStack(alignment: .bottom) {
                    Text(roundedLevel)
                        .font(.title)
                        .foregroundStyle(Color(.title))
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(alignment: .bottom) {
                            Text(completionLevel)
                                .foregroundStyle(.title)
                            Spacer()
                            Button {
                                showGradeDialog = true
                            } label: {
                                Label(cursus[currentIndex].cursus.name, systemImage: "chevron.down")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(width: 100, height: 30, alignment: .center)
                                    .background(Color.cursusChipBg.opacity(0.1))
                                    .foregroundColor(.cursusChipText)
                                    .cornerRadius(20)
                                    .font(.caption)
                            }
                            .confirmationDialog("Choose a cursus", isPresented: $showGradeDialog, titleVisibility: .visible) {
                                ForEach(Array(cursus.enumerated()), id: \.offset) { index, item in
                                    Button(item.cursus.name) {
                                        cursusIndex = index;
                                    }
                                }
                            }
                        }
                        LinearProgressView(value: cursus[currentIndex].level - floor(cursus[currentIndex].level), shape: Capsule())
                            .tint(currentIndex == 0
                                  ? LinearGradient(colors: [Color(.progressMainStart), Color(.progressMainEnd)], startPoint: .leading, endPoint: .trailing)
                                  : LinearGradient(colors: [Color(.progressAltStart), Color(.progressAltEnd)], startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(height: 5)
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
    
    var currentIndex: Int {
        min(cursusIndex, max(user.cursus.count - 1, 0))
    }
    
    var roundedLevel: String {
        String(format: "%0.f", floor(user.cursus[currentIndex].level));
    }
    
    var completionLevel: String {
        let level = String(String(user.cursus[currentIndex].level).split(separator: ".").last ?? "");
        return level.count == 1 ? level + "0%" : level + "%";
    }
}

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var selectedCursusIndex = 0

    var body: some View {
        LevelBarView(user: User.example, cursusIndex: $selectedCursusIndex)
    }
}
