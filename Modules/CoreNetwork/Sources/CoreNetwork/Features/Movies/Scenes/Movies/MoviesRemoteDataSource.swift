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
            RequestMethod(.get)
        }
        .logInConsole(.debugEnabled)
        .keyPath(\.results)
        .decode([GenreResponseDTO].self)
        .extractPayload()
        .result()
    }

    public func getMovie(_ id: Int) async throws -> MovieDetailResponseDTO {
        try await DataTask {
            TMDbHeaders()
            Path("movie/\(id)")
            RequestMethod(.get)
        }
        .logInConsole(.debugEnabled)
        .decode(MovieDetailResponseDTO.self, decoder: .default)
        .extractPayload()
        .result()
    }

    public func getMovies(at page: Int) async throws -> [MovieResponseDTO] {
        try await DataTask {
            TMDbHeaders()
            Path("movie/upcoming")
            Query(page, forKey: "page")
            RequestMethod(.get)
        }
        .logInConsole(.debugEnabled)
        .keyPath(\.results)
        .decode([MovieResponseDTO].self, decoder: .default)
        .extractPayload()
        .result()
    }

    public func getPhoto(for path: String) async throws -> Data {
        try await DataTask {
            BaseURL("image.tmdb.org")
            Path("t/p/w500\(path)")
            Headers.Accept(.png)
            RequestMethod(.get)
        }
        .logInConsole(.debugEnabled)
        .extractPayload()
        .result()
    }
}
