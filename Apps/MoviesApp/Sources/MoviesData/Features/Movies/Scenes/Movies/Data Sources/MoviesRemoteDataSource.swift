//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation
import Factory

public protocol MoviesRemoteDataSource: Sendable {

    func getGenres() async throws -> [GenreResponseDTO]

    func getMovie(_ id: Int) async throws -> MovieDetailResponseDTO

    func getMovies(at page: Int) async throws -> [MovieResponseDTO]

    func getPhoto(for path: String) async throws -> Data
}

extension Container {

    public var moviesRemoteDataSource: Factory<MoviesRemoteDataSource> {
        self { fatalError() }
    }
}
