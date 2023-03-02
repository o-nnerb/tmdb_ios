//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import DataKit
import Injection
import RequestDL

public struct MoviesRemoteDataSource {

    public init() {}
}

extension MoviesRemoteDataSource: DataKit.MoviesRemoteDataSource {

    public func getGenres() async throws -> [GenreResponseDTO] {
        try await DataTask {
            TMDbHeaders()
            Path("genre/movie/list")
            Method(.get)
        }
        .logInConsole(.debugEnabled)
        .keyPath(\.results)
        .decode([GenreResponseDTO].self)
        .ignoreResponse()
        .response()
    }

    public func getMovie(_ id: Int) async throws -> MovieDetailResponseDTO {
        try await DataTask {
            TMDbHeaders()
            Path("movie/\(id)")
            Method(.get)
        }
        .logInConsole(.debugEnabled)
        .decode(MovieDetailResponseDTO.self, decoder: .default)
        .detach {
            switch $0 {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
        .ignoreResponse()
        .response()
    }

    public func getMovies(at page: Int) async throws -> [MovieResponseDTO] {
        try await DataTask {
            TMDbHeaders()
            Path("movie/upcoming")
            Query(page, forKey: "page")
            Method(.get)
        }
        .logInConsole(.debugEnabled)
        .keyPath(\.results)
        .decode([MovieResponseDTO].self, decoder: .default)
        .ignoreResponse()
        .response()
    }

    public func getPhoto(for path: String) async throws -> Data {
        try await DataTask {
            BaseURL("image.tmdb.org")
            Path("t/p/w500\(path)")
            Headers.Accept(.png)
            Method(.get)
        }
        .logInConsole(.debugEnabled)
        .ignoreResponse()
        .response()
    }
}
