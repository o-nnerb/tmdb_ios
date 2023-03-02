//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation

public protocol MoviesRepositoryProtocol {

    func getGenre(_ id: Int) async throws -> GenreResponse

    func getMovie(_ id: Int) async throws -> MovieDetailResponse

    func getMovies(at page: Int) async throws -> [MovieResponse]

    func getPhoto(for path: String) async throws -> Data
}
