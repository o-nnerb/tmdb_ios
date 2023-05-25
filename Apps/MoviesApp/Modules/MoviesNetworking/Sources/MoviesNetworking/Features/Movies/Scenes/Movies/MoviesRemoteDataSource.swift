//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import MoviesData
import Injection
import RequestDL

public struct MoviesRemoteDataSource {

    public init() {}
}

extension MoviesRemoteDataSource: MoviesData.MoviesRemoteDataSource {

    public func getGenres() async throws -> [GenreResponseDTO] {
        try await DataTask {
            TMDbHeaders()
            Path("genre/movie/list")
            RequestMethod(.get)
                .cacheStrategy(.returnCachedDataElseLoad)
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
                .cachePolicy(.memory)
                .cacheStrategy(.returnCachedDataElseLoad)
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
                .cachePolicy(.disk)
                .cacheStrategy(.reloadAndValidateCachedData)
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
                .cachePolicy(.disk)
                .cacheStrategy(.returnCachedDataElseLoad)
                .cache(
                    memoryCapacity: 40 * 1_024 * 1_024,
                    diskCapacity: 320 * 1_024 * 1_024,
                    suiteName: "temp.images"
                )
        }
        .logInConsole(.debugEnabled)
        .extractPayload()
        .result()
    }
}
