//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import Factory

public protocol GetUpcomingMoviesUseCaseProtocol: Sendable {

    func callAsFunction(at page: Int) async throws -> [MovieResponse]
}

public struct GetUpcomingMoviesUseCase {

    @Injected(\.moviesRepository) var repository

    public init() {}
}

extension GetUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol {

    public func callAsFunction(at page: Int) async throws -> [MovieResponse] {
        try await repository.getMovies(at: page)
    }
}

extension Container {

    public var getUpcomingMoviesUseCase: Factory<GetUpcomingMoviesUseCaseProtocol> {
        self { GetUpcomingMoviesUseCase() }
    }
}
