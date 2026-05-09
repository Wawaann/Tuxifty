//
//  AuthService.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

protocol TokenService {
    func fetch() async throws -> Token;
}
