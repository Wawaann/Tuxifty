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
    
    init(
        userModel: User,
        userViewModel: UserViewModel
    ) {
        self.userModel = userModel;
        self.userViewModel = userViewModel;
        _selectedCursusIndex = userModel.cursus.count > 1 ? State(initialValue: 1) : State(initialValue: 0);
    }
    
    var body: some View {
        ZStack {
            Color(.testcolor)
            
            VStack(alignment: .leading) {
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
                    .fontWeight(.regular)
                    .foregroundStyle(.blue)
                    .padding(.vertical, 5)
                }
                .clipShape(Capsule())
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.blue.opacity(0.35), lineWidth: 1)
                )
                .buttonStyle(.plain)
                
                HeaderView(user: userModel, selectedCursusIndex: $selectedCursusIndex)
                
                TabView {
                    ProjectsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
                        .padding(.bottom, 10)
                        .background(Color(.testcolor))
                        .tabItem {
                            Label("Projects", systemImage: "clipboard")
                        }
                    SkillsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
                        .padding(.bottom, 10)
                        .tabItem {
                            Label("Skills", systemImage: "brain")
                        }
                    AchievementsView(achievements: userModel.achievements)
                        .padding(.bottom, 10)
                        .tabItem {
                            Label("Achievements", systemImage: "book")
                        }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    
    let service: UserService = MockUserService();
    let userVM: UserViewModel = UserViewModel(service: service);
    
    HomeView(userModel: User.example, userViewModel: userVM);
}

//                TabView {
//                    Tab("Projects", systemImage: "clipboard") {
//                        ProjectsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
//                            .padding(.bottom, 10)
//                    }
//                    Tab("Skills", systemImage: "brain") {
//                        SkillsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
//                            .padding(.bottom, 10)
//                    }
//                    Tab("Achievements", systemImage: "book") {
//                        AchievementsView(achievements: userModel.achievements)
//                            .padding(.bottom, 10)
//                    }
//                }
