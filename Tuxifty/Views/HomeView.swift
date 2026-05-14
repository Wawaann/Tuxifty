//
//  HomeView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 03/04/2026.
//

import SwiftUI

struct HomeView: View {
    var userModel: User;
    var userViewModel: UserViewModel;
    @State private var selectedCursusIndex: Int;
    @State private var selectedTab: Int = 0;
    
    init(
        userModel: User,
        userViewModel: UserViewModel
    ) {
        self.userModel = userModel;
        self.userViewModel = userViewModel;
        _selectedCursusIndex = userModel.cursus.count > 1 ? State(initialValue: 1) : State(initialValue: 0);
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                backButton(color: selectedCursusIndex == 0
                           ? Color(.progressMainStart)
                           : Color(.progressAltStart)
                )
                
                HeaderView(user: userModel, selectedCursusIndex: $selectedCursusIndex)
            }
            .padding(.horizontal, 10)
            
            ZStack {
                switch selectedTab {
                case 0:
                    ProjectsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
                case 1:
                    SkillsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
                case 2:
                    AchievementsView(achievements: userModel.achievements, selectedCursusIndex: selectedCursusIndex)
                default:
                    EmptyView()
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
            Spacer(minLength: 0)
            
            CustomTabBar(
                color: selectedCursusIndex == 0
                    ? Color(.progressMainStart)
                    : Color(.progressAltStart),
                selectedTab: $selectedTab
            )
        }
    }
    
    @ViewBuilder
    private func backButton(color: Color) -> some View {
        Button {
            Task { userViewModel.reset() }
        } label: {
            HStack(spacing: 2) {
                Image(systemName: "chevron.left")
                    .padding(.leading, 10)
                    .font(.subheadline)
                Text("Back")
                    .padding(.trailing, 10)
            }
            .fontWeight(.semibold)
            .foregroundStyle(color)
            .padding(.vertical, 5)
        }
        .clipShape(Capsule())
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial.opacity(0.35))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(color.opacity(0.35), lineWidth: 1)
        )
        .buttonStyle(.plain)
    }
}

#Preview {
    
    let service: UserService = MockUserService();
    let userVM: UserViewModel = UserViewModel(service: service);
    
    HomeView(userModel: User.example, userViewModel: userVM);
}
