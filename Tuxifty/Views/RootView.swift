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
            Color(.testcolor)
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
