//
//  Achievements.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 09/04/2026.
//

import Foundation

struct Achievements42: Codable, Identifiable, Equatable {
    var id: Int;
    var name: String;
    var description: String;
    var tier: String;
    var kind: String;
    var image: String;
    var nbrOfSuccess: Int?;
    
    enum CodingKeys: String, CodingKey {
        case id;
        case name;
        case description;
        case tier;
        case kind;
        case image;
        case nbrOfSuccess = "nbr_of_success";
    }
    
    static var example: Achievements42 {
        let user = MockUserService().fetchUser();
        return user.achievements.first!;
    }
    
    static var tabExample: [Achievements42] {
        let user = MockUserService().fetchUser();
        return user.achievements;
    }
}
