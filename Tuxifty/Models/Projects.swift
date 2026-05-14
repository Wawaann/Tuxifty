//
//  Projects.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 09/04/2026.
//

import Foundation

struct ProjectName: Codable, Equatable {
    var name: String;
}

struct Project42: Codable, Identifiable, Equatable {
    var id: Int;
    var finalMark: Int?;
    var status: String;
    var validated: Bool?;
    var project: ProjectName;
    var cursusIds: [Int];
    var markedAt: String?;
    var createdAt: String;
    
    enum CodingKeys: String, CodingKey {
        case id;
        case finalMark = "final_mark";
        case status;
        case validated = "validated?";
        case project;
        case cursusIds = "cursus_ids";
        case markedAt = "marked_at";
        case createdAt = "created_at";
    }
    
    static var example: Project42 {
        let user = MockUserService().fetchUser();
        return user.projects.first!;
    }
}
