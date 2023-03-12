//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import Injection

public protocol GetUpcomingMoviesUseCaseProtocol {

    func callAsFunction(at page: Int) async throws -> [MovieResponse]
}

public struct GetUpcomingMoviesUseCase {

    @Injected var repository: MoviesRepositoryProtocol

    public init() {}
}

extension GetUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol {

    public func callAsFunction(at page: Int) async throws -> [MovieResponse] {
        try await repository.getMovies(at: page)
    }
}
