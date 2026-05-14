//
//  SwiftUIView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 07/04/2026.
//

import SwiftUI

struct HeaderView: View {
    let user: User;
    @Binding var selectedCursusIndex: Int;

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading) {
                profileImage
                    .padding(.leading, 5)
                    .padding(.bottom, 5)
                
                chipPoints(color: selectedCursusIndex == 0
                           ? Color(.progressMainStart)
                           : Color(.progressAltStart))
            }

            VStack(alignment: .leading, spacing: 35) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(user.login)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.title)
                        
                        Spacer()
                        
                        Text(user.location ?? "Not log")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    if let campus = user.campus.first {
                        Text(campus.name)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                LevelBarView(user: user, cursusIndex: $selectedCursusIndex)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial.opacity(0.35))
                .shadow(color: Color.shadow.opacity(0.12), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.cardBorder.opacity(0.35), lineWidth: 1)
        )
    }

    private var profileImage: some View {
        Group {
            if let url = URL(string: user.image.link) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image("Incognito")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .frame(width: 90, height: 90)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.avatarBorder.opacity(0.65), lineWidth: 2)
        )
    }
    
    @ViewBuilder
    private func chipPoints(color: Color) -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 4) {
                Image(systemName: "australsign")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundStyle(color)

                Text("\(user.wallet)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.title)
                    .monospacedDigit()
            }

            HStack(spacing: 4) {
                Text("EvP")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundStyle(color)

                Text("\(user.correctionPoint)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.title)
                    .monospacedDigit()
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(color.opacity(0.12))
        .overlay(
            Capsule()
                .stroke(color.opacity(0.25), lineWidth: 1)
        )
        .clipShape(Capsule())
    }
}

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var selectedCursusIndex = 0;

    var body: some View {
        HeaderView(user: User.example, selectedCursusIndex: $selectedCursusIndex)
    }
}
