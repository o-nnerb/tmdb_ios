//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation
import CoreApp
import Injection

public protocol MoviesRemoteDataSource {

    func getGenres() async throws -> [GenreResponseDTO]

    func getMovie(_ id: Int) async throws -> MovieDetailResponseDTO

    func getMovies(at page: Int) async throws -> [MovieResponseDTO]

    func getPhoto(for path: String) async throws -> Data
}
