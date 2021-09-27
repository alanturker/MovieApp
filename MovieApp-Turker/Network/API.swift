//
//  API.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import Foundation
import Moya

enum MovieAPI {
    case search(query: String)
    case popular
    case upcoming
    case topRated
    case cast(movieID: Int)
}

fileprivate let apiKey = "98c068aacfd03daaa1e7936e01146411"
fileprivate let url: String = "https://api.themoviedb.org/3/"

extension MovieAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: url) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .search(_):
            return "search/movie"
        case .upcoming:
            return "movie/upcoming"
        case .topRated:
            return "movie/top_rated"
        case .cast(let movieID):
            return "movie/\(movieID)/credits"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular, .search(_), .upcoming, .topRated, .cast(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .popular, .upcoming, .topRated:
            return .requestParameters(parameters: ["api_key" : apiKey], encoding: URLEncoding.queryString)
        case .search(query: let query):
            return .requestParameters(parameters: ["api_key" : apiKey, "query": query], encoding: URLEncoding.queryString)
        case .cast(movieID: let movieID):
            return .requestParameters(parameters: ["api_key" : apiKey, "movie_id": movieID], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
