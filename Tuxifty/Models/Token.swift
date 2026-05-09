//
//  TokenResponse.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 01/04/2026.
//

import Foundation

struct Token: Codable, Equatable {
    let accessToken: String;
    let tokenType: String;
    let expiresIn: Int;

    enum CodingKeys: String, CodingKey {
        case accessToken  = "access_token";
        case tokenType    = "token_type";
        case expiresIn    = "expires_in";
    }
}
