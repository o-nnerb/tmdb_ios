//
//  TMDbAPI+Endpoint.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import Moya
import ReactiveMoya

extension TMDbAPI {
    enum Endpoint: TargetType {
        case upcomingMovies(page: Int)
        case genres
        case movie(Int)
    }
}

extension TMDbAPI.Endpoint {
    /// The target's base `URL`.
    var baseURL: URL {
        URL(string: TMDbAPI.basePath)!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .upcomingMovies:
            return "/movie/upcoming"
        case .genres:
            return "/genre/movie/list"
        case .movie(let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .upcomingMovies, .genres, .movie:
            return .get
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        .init()
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .upcomingMovies(let page):
            return .requestParameters(
                parameters: [
                    "api_key": TMDbAPI.token,
                    "page": page
                ],
                encoding: URLEncoding()
            )
        default:
            return .requestParameters(
                parameters: [
                    "api_key": TMDbAPI.token
                ],
                encoding: URLEncoding()
            )
        }
    }
    
    /// The headers to be used in the request.
    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
}
