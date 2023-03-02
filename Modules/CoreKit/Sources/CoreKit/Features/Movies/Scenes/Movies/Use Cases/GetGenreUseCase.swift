//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation
import Injection

public protocol GetGenreUseCaseProtocol {

    func callAsFunction(_ id: Int) async throws -> GenreResponse
}

public struct GetGenreUseCase {

    @Injected var repository: MoviesRepositoryProtocol

    public init() {}
}

extension GetGenreUseCase: GetGenreUseCaseProtocol {

    public func callAsFunction(_ id: Int) async throws -> GenreResponse {
        try await repository.getGenre(id)
    }
}
