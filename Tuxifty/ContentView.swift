//
//  ContentView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import SwiftUI

// https://api.intra.42.fr/v2/projects_users?filter\[project_id\]=1428&filter\[user_id\]=202541

struct ContentView: View {
    
    @State var tokenViewModel: TokenViewModel = TokenViewModel();
    let userService: UserService

    init(
        tokenViewModel: TokenViewModel = TokenViewModel(),
        userService: UserService = DefaultUserService()
    ) {
        _tokenViewModel = State(initialValue: tokenViewModel);
        self.userService = userService;
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                switch tokenViewModel.state {
                case .idle:
                    Text("No data yet")
                case .loading:
                    ProgressView {
                        Text("Loading data")
                    }
                case .loaded(_):
                    RootView(token: tokenViewModel, userService: userService)
                case .error(let error):
                    VStack(spacing: 20) {
                        Text("Something went wrong")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.title))

                        Text(error)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.pink)

                        Button {
                            Task {
                                await tokenViewModel.fetchToken();
                            }
                        } label: {
                            Text("Reload Data")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(.buttonBackground)
                                .clipShape(Capsule())
                                .contentShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(20)
                    .frame(maxWidth: 420)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.ultraThinMaterial.opacity(0.35))
                            .shadow(color: Color.shadow.opacity(0.15), radius: 9, x: 0, y: 4)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.cardBorder.opacity(0.35), lineWidth: 1)
                    )
                    .padding(.horizontal)
                }
            }
            .task {
                await tokenViewModel.fetchToken();
            }
        }
    }
}

#Preview {
    
    let service: TokenService = MockTokenService();
    let tokenVM: TokenViewModel = TokenViewModel(service: service);
    
    ContentView(tokenViewModel: tokenVM, userService: MockUserService());
}
