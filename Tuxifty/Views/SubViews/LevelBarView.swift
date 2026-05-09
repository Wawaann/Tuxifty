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
                HStack(alignment: .center) {
                    Text(roundedLevel)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        HStack {
                            Text(completionLevel)
                            Spacer()
                            Button {
                                showGradeDialog = true
                            } label: {
                                Label(cursus[currentIndex].cursus.name, systemImage: "chevron.down")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(width: 130, height: 40, alignment: .center)
                                    .background(Color.gray.opacity(0.1))
                                    .foregroundColor(.black)
                                    .cornerRadius(20)
                                    .font(.footnote)
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
                                  ? LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                                  : LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(height: 7)
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
