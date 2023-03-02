//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import Injection

public protocol GetMovieUseCaseProtocol {

    func callAsFunction(_ id: Int) async throws -> MovieDetailResponse
}

public struct GetMovieUseCase {

    @Injected var repository: MoviesRepositoryProtocol

    public init() {}
}

extension GetMovieUseCase: GetMovieUseCaseProtocol {

    public func callAsFunction(_ id: Int) async throws -> MovieDetailResponse {
        try await repository.getMovie(id)
    }
}
