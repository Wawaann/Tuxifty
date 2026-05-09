//
//  MockAuthService.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

struct MockTokenService: TokenService {
    
    private func loadTokenSampleData() throws -> Token {
        guard let url = Bundle.main.url(forResource: "TokenSampleData", withExtension: "json") else {
            throw APIError.invalidURL;
        }
        do {
            let data = try Data(contentsOf: url);
            return try JSONDecoder().decode(Token.self, from: data);
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }

    }
    
    func fetch() async throws -> Token {
        let token = try loadTokenSampleData();
        return token;
    }
}
