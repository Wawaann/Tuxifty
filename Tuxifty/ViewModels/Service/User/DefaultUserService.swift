//
//  DefaultUserService.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

struct DefaultUserService: UserService {
    func fetch(from token: TokenViewModel, for login: String) async throws -> User {
        
        let url =  URL(string: SecretsDecoder.apiURL + "/v2/users/" + login.lowercased());
        guard let requestUrl = url else {
            throw APIError.invalidURL;
        }
        
        var request = URLRequest(url: requestUrl);
        
        guard let initialAccessToken = token.token?.accessToken else {
            throw APIError.invalidResponse;
        }
        
        request.setValue(
            "Bearer \(initialAccessToken)",
            forHTTPHeaderField: "Authorization"
        );
        
        do {
            var (data, response) = try await URLSession.shared.data(for: request);
            
            guard var httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse;
            }
            
            if httpResponse.statusCode == 401 {
                await token.refreshToken();
                
                guard let refreshedAccessToken = token.token?.accessToken else {
                    throw APIError.invalidResponse;
                }
                
                request.setValue(
                    "Bearer \(refreshedAccessToken)",
                    forHTTPHeaderField: "Authorization"
                );
                
                (data, response) = try await URLSession.shared.data(for: request);
                
                guard let refreshedHttpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse;
                }
                
                httpResponse = refreshedHttpResponse;
            }
            
            if httpResponse.statusCode == 404 {
                throw APIError.invalidLogin;
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                throw APIError.invalidURL;
            }
            
            return try JSONDecoder().decode(User.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
