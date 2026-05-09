//
//  APIError.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL;
    case invalidResponse;
    case invalidLogin;
    case decodingError(Error);
    case networkError(Error);
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid";
        case .invalidResponse:
            return "Invalid response from server";
        case .invalidLogin:
            return "Login not found";
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)";
        case .networkError(let error):
            return "Network error: \(error.localizedDescription) ";
        }
    }
}
