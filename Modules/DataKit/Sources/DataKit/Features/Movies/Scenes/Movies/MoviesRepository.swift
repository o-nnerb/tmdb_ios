//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import CoreKit
import Injection

public struct MoviesRepository {

    @Injected var remote: MoviesRemoteDataSource
    @Injected var local: MoviesLocalDataSource

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
        do {
            return try local.getPhoto(path)
        } catch {}

        let data = try await remote.getPhoto(for: path)
        try local.setPhoto(data, forPath: path)
        return data
    }
}
