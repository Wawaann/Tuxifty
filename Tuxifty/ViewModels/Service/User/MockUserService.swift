//
//  MockUserService.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

struct MockUserService: UserService {
    
    private func loadUserSampleData() throws -> User {
        guard let url = Bundle.main.url(forResource: "UserSampleData", withExtension: "json") else {
            throw APIError.invalidURL;
        }
        
        do {
            let data = try Data(contentsOf: url);
            return try JSONDecoder().decode(User.self, from: data);
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    func fetch(from token: TokenViewModel, for login: String) async throws -> User {
        if login != "ebigotte" {
            throw APIError.invalidURL;
        }
        let user: User = try loadUserSampleData();
        return user;
    }
    
    func fetchUser() -> User {
        let user: User = try! loadUserSampleData();
        return user;
    }
}
