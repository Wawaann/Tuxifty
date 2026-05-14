//
//  DefaultAuthService.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

struct DefaultTokenService: TokenService {
    
    let apiURL: String = SecretsDecoder.apiURL;
    let apiUID: String = SecretsDecoder.apiUID;
    let apiKEY: String = SecretsDecoder.apiKEY;
    
    func fetch() async throws -> Token {
        
        let url = URL(string: apiURL + "/oauth/token");
        let postBody = "grant_type=client_credentials&client_id=\(apiUID)&client_secret=\(apiKEY)";
        
        guard let requestUrl = url else {
            throw APIError.invalidURL;
        }
        
        var request = URLRequest(url: requestUrl);
        request.httpMethod = "POST";
        request.httpBody = postBody.data(using: String.Encoding.utf8);
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request);
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse;
            }
            
            return try JSONDecoder().decode(Token.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
