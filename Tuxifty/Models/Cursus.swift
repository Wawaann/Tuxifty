//
//  Cursus.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 09/04/2026.
//

import Foundation

struct Skill42: Codable, Identifiable, Equatable {
    var id: Int;
    var name: String;
    var level: Double;
    
    static var example: Skill42 {
        let user = MockUserService().fetchUser();
        return Skill42(id: user.id, name: "Rigor", level: 8.06);
    }
}

struct CursusInfo42: Codable, Identifiable, Equatable {
    var id: Int;
    var name: String;
}

struct Cursus42: Codable, Identifiable, Equatable {
    var id: Int;
    var grade: String?;
    var level: Double;
    var skills: [Skill42];
    var cursus: CursusInfo42;
}
