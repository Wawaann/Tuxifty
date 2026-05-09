//
//  UserViewModel.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 03/04/2026.
//

import Foundation

@Observable
class UserViewModel {
    
    enum State: Equatable {
        case idle;
        case loading;
        case loaded(User);
    }
    
    var state: State = .idle;
    var service: UserService;
    var error: String?;
    
    init(service: UserService = DefaultUserService()) {
        self.service = service;
    }
    
    func fetch(from token: TokenViewModel, for login: String) async {
        
        guard self.state != .loading else { return; }
        
        self.state = .loading;
        
        do {
            let user: User = try await self.service.fetch(from: token, for: login);
            self.state = .loaded(user);
        } catch let error as APIError {
            self.state = .idle;
            self.error = error.localizedDescription;
        } catch {
            self.state = .idle;
            self.error = "Unknown error: \(error)";
        }
    }
    
    func reset() {
        self.state = .idle;
    }
    
    func resetError() {
        self.error = nil;
    }
}

import Playgrounds

#Playground {
    let service = MockUserService();
    let vm = UserViewModel(service: service);
    let tokenService = MockTokenService();
    let tokenVM = TokenViewModel(service: tokenService);
    
    await vm.fetch(from: tokenVM, for: "ebigotte");
    
    switch vm.state {
        case .idle: print("idle");
        case .loading: print("loading");
        case .loaded(let user):
            print(user);
    }
}
