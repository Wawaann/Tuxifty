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
        _tokenViewModel = State(initialValue: tokenViewModel)
        self.userService = userService
    }
    
    var body: some View {
        Group {
            switch tokenViewModel.state {
            case .idle:
                Text("No data yet");
            case .loading:
                ProgressView {
                    Text("Loading data")
                }
            case .loaded(_):
                RootView(token: tokenViewModel, userService: userService);
            case .error(let error):
                Text("Error: \(error)")
                    .foregroundStyle(Color.pink);
            }
        }
        .task {
            await tokenViewModel.fetchToken();
        }
    }
}

#Preview {
    
    let service: TokenService = MockTokenService();
    let tokenVM: TokenViewModel = TokenViewModel(service: service);
    
    ContentView(tokenViewModel: tokenVM, userService: MockUserService());
}
