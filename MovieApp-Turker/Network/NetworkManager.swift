//
//  NetworkManager.swift
//  MovieApp-Turker
//
//  Created by Erol on 22.09.2021.
//

import Foundation
import Moya

final class NetworkManager {
    
    var provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin()])
    
    typealias movieCompletion = ([Movie]) -> ()
    typealias castCompletion = ([Cast]) -> ()
    
    func fetchPopularMovies(completionHandler: @escaping movieCompletion) {
        provider.request(.popular) { movieResponse in
            switch movieResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(DataResults.self, from: response.data)
                    completionHandler(results.movies)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
    
    func fetchTopRatedMovies(completionHandler: @escaping movieCompletion) {
        provider.request(.topRated) { movieResponse in
            switch movieResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(DataResults.self, from: response.data)
                    completionHandler(results.movies)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
    
    func fetchUpcomingMovies(completionHandler: @escaping movieCompletion) {
        provider.request(.upcoming) { movieResponse in
            switch movieResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(DataResults.self, from: response.data)
                    completionHandler(results.movies)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
    
    func fetchCastMovie(movieID: Int, completionHandler: @escaping castCompletion) {
        provider.request(.cast(movieID: movieID)) { movieResponse in
            switch movieResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(CastResults.self, from: response.data)
                    completionHandler(results.castResults)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
    
    func searchMovies(query: String, completionHandler: @escaping movieCompletion) {
        provider.request(.search(query: query)) { movieResponse in
            switch movieResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(DataResults.self, from: response.data)
                    completionHandler(results.movies)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
}
