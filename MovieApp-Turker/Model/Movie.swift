//
//  Movie.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import Foundation

struct DataResults: Codable {
    let page: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results", page
    }
}

struct Movie: Codable {
    let title: String?
    let posterPath: String?
    let overview: String?
    let id: Int?
    let rate: Double?
    let backDrop: String?
    var posterURL: URL? {
        let url = URL(string: "https://image.tmdb.org/t/p/original\(posterPath ?? "")")
        return url
    }

    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path", title, overview, id, rate = "vote_average", backDrop = "backdrop_path"
    }
}

