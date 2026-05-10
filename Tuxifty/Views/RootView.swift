//
//  RootView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 27/04/2026.
//

import SwiftUI

struct RootView: View {
    
    @State var token: TokenViewModel;
    @State private var userViewModel: UserViewModel;
    
    init(
        token: TokenViewModel,
        userService: UserService = DefaultUserService() // prod par défaut
    ) {
        _token = State(initialValue: token);
        _userViewModel = State(initialValue: UserViewModel(service: userService));
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Color(.base)

                RadialGradient(
                    colors: [
                        Color.radialTopLeading.opacity(0.35),
                        Color.radialTopLeading.opacity(0.0)
                    ],
                    center: .topLeading,
                    startRadius: 20,
                    endRadius: 320
                )

                RadialGradient(
                    colors: [
                        Color.radialTrailing.opacity(0.30),
                        Color.radialTrailing.opacity(0.0)
                    ],
                    center: .trailing,
                    startRadius: 10,
                    endRadius: 280
                )

                RadialGradient(
                    colors: [
                        Color.radialBottom.opacity(0.25),
                        Color.radialBottom.opacity(0.0)
                    ],
                    center: .bottom,
                    startRadius: 30,
                    endRadius: 300
                )
            }
            .ignoresSafeArea()
            
            Group {
                switch userViewModel.state {
                case .idle:
                    LoginView(userViewModel: userViewModel, tokenViewModel: token)
                        .padding(.horizontal, 20)
                case .loading:
                    ProgressView()
                case .loaded(let user):
                    HomeView(userModel: user, userViewModel: userViewModel)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .errorToast(errorMessage: userViewModel.error) {
                userViewModel.resetError();
            }
        }
    }
}

#Preview {
    
    let tokenService: TokenService = MockTokenService();
    let tokenVM: TokenViewModel = TokenViewModel(service: tokenService);
    
    RootView(token: tokenVM, userService: MockUserService())
        .task {
            await tokenVM.fetchToken()
        }
}
