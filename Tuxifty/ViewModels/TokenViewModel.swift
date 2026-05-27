//
//  AuthenticateViewModel.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

@Observable
class TokenViewModel {
    
    enum State: Equatable {
        case idle;
        case loading;
        case loaded(Token);
        case error(String);
    }
    
    var state: State = .idle;
    var service: TokenService;
    
    var token: Token? {
        if case .loaded(let token) = self.state {
            return token;
        }
        
        return nil;
    }
    
    init(service: TokenService = DefaultTokenService()) {
        self.service = service;
    }
    
    func fetchToken() async {

        if self.state != .idle {
            guard case .error = self.state else { return; }
        }
        
        self.state = .loading;
        
        do {
            let token: Token = try await self.service.fetch();
            self.state = .loaded(token);
        } catch let error as APIError {
            self.state = .error(error.localizedDescription);
        } catch {
            self.state = .error("Unknown error: \(error)");
        }
    }
    
    func refreshToken() async {
        do {
            let token: Token = try await self.service.fetch();
            self.state = .loaded(token);
        } catch let error as APIError {
            self.state = .error(error.localizedDescription);
        } catch {
            self.state = .error("Unknown error: \(error)");
        }
    }
}

import Playgrounds

#Playground {
    let service = MockTokenService();
    let vm = TokenViewModel(service: service);
    
    await vm.fetchToken();
    
    switch vm.state {
        case .idle: print("idle");
        case .loading: print("loading");
        case .loaded(let token):
            print(token);
        case .error(let error): print(error);
    }
}
