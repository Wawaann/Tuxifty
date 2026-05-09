//
//  UserService.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 26/04/2026.
//

import Foundation

protocol UserService {
    func fetch(from token: TokenViewModel, for login: String) async throws -> User;
}
