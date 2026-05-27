//
//  LoginView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 03/04/2026.
//

import SwiftUI

struct LoginView: View {

    var userViewModel: UserViewModel;
    var tokenViewModel: TokenViewModel;
    @State var login: String = "";
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Tuxifty")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color(.title))
            
            TextField("Login", text: $login)
                .textContentType(.username)
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 999, style: .continuous)
                        .fill(.inputBackground)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 999, style: .continuous)
                        .stroke(Color.inputBorder, lineWidth: 2)
                )
            
            Button {
                Task {
                    await userViewModel.fetch(from: tokenViewModel, for: login)
                }
            } label: {
                Text("Login")
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
        .padding(24)
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
    }
}

#Preview {
    
    let userService: UserService = MockUserService();
    let userVM: UserViewModel = UserViewModel(service: userService);
    let tokenService: TokenService = MockTokenService();
    let tokenVM: TokenViewModel = TokenViewModel(service: tokenService);
    
    LoginView(userViewModel: userVM, tokenViewModel: tokenVM);
}
