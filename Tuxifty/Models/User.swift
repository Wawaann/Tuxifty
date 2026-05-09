//
//  File.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 03/04/2026.
//

import Foundation

struct Image42: Codable, Equatable {
    var link: String;
}

struct Campus42: Codable, Identifiable, Equatable {
    var id: Int;
    var name: String;
}

struct User: Codable, Equatable {
    var id: Int;
    var login: String;
    var image: Image42;
    var displayName: String?;
    var location: String?;
    var cursus: [Cursus42];
    var campus: [Campus42];
    var projects: [Project42];
    var achievements: [Achievements42];
    
    enum CodingKeys: String, CodingKey {
        case id;
        case login;
        case image;
        case displayName = "displayname";
        case location;
        case cursus = "cursus_users";
        case campus;
        case projects = "projects_users";
        case achievements;
    }
    
    static var example: User {
        MockUserService().fetchUser();
    }
}
