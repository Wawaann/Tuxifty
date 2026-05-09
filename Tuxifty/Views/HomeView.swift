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
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.95, green: 0.97, blue: 1.0),
                    Color(red: 0.91, green: 0.95, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        
            VStack(alignment: .leading) {
                Group {
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
                }
                .padding(.horizontal, 10)
                
                ZStack {
                    switch selectedTab {
                    case 0:
                        ProjectsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
                    case 1:
                        SkillsView(user: userModel, selectedCursusIndex: selectedCursusIndex)
                    case 2:
                        AchievementsView(achievements: userModel.achievements)
                    default:
                        EmptyView()
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                Spacer(minLength: 0)
                
                CustomTabBar(selectedTab: $selectedTab)
            }
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
