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
            profileImage

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(user.login)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.title)
                    
                    if let location = user.location, !location.isEmpty {
                        Spacer()
                        
                        Text(location)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                if let campus = user.campus.first {
                    Text(campus.name)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                LevelBarView(user: user, cursusIndex: $selectedCursusIndex)
                    .padding(.top, 4)
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
}

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var selectedCursusIndex = 0

    var body: some View {
        HeaderView(user: User.example, selectedCursusIndex: $selectedCursusIndex)
    }
}
