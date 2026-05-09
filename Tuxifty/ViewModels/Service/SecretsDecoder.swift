//
//  SecretsDecoder.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 01/04/2026.
//

import Foundation

enum SecretsDecoder {
    static var apiKEY: String {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Can't find API_KEY in Info.plist");
        }
        return key;
    }
    
    static var apiUID: String {
        guard let uid = Bundle.main.infoDictionary?["API_UID"] as? String else {
            fatalError("Can't find API_UID in Info.plist");
        }
        return uid;
    }
    
    static var apiURL: String {
        guard let url = Bundle.main.infoDictionary?["API_URL"] as? String else {
            fatalError("Can't find API_URL in Info.plist");
        }
        return "https://" + url;
    }
}
