//
//  Cast.swift
//  MovieApp-Turker
//
//  Created by Gülşah Alan on 23.09.2021.
//

import Foundation

struct CastResults: Codable {
    let castResults: [Cast]
    
    private enum CodingKeys: String, CodingKey {
        case castResults = "cast"
    }
}

struct Cast: Codable {
    let name: String?
    let profile: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, profile = "profile_path"
    }
    
}

