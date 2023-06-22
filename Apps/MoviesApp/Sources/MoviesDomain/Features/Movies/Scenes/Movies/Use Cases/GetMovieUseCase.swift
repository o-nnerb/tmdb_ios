//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import Factory

public protocol GetMovieUseCaseProtocol {

    func callAsFunction(_ id: Int) async throws -> MovieDetailResponse
}

public struct GetMovieUseCase {

    @Injected(\.moviesRepository) var repository

    public init() {}
}

extension GetMovieUseCase: GetMovieUseCaseProtocol {

    public func callAsFunction(_ id: Int) async throws -> MovieDetailResponse {
        try await repository.getMovie(id)
    }
}

extension Container {

    public var getMovieUseCase: Factory<GetMovieUseCaseProtocol> {
        self { GetMovieUseCase() }
    }
}
