//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import MoviesDomain
import Factory

public struct MoviesRepository {

    @Injected(\.moviesRemoteDataSource) var remote
    @Injected(\.moviesLocalDataSource) var local

    public init() {}
}

extension MoviesRepository: MoviesRepositoryProtocol {

    public func getGenre(_ id: Int) async throws -> GenreResponse {
        do {
            return try local.getGenre(id).toDomain
        } catch {}

        let genres = try await remote.getGenres()
        try local.setGenres(genres)
        return try local.getGenre(id).toDomain
    }

    public func getMovie(_ id: Int) async throws -> MovieDetailResponse {
        try await remote.getMovie(id).toDomain
    }

    public func getMovies(at page: Int) async throws -> [MovieResponse] {
        try await remote.getMovies(at: page).map(\.toDomain)
    }

    public func getPhoto(for path: String) async throws -> Data {
        try await remote.getPhoto(for: path)
    }
}
