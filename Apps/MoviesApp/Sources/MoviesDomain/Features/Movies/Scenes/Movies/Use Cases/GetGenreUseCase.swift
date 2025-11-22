//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation
import Factory

public protocol GetGenreUseCaseProtocol: Sendable {

    func callAsFunction(_ id: Int) async throws -> GenreResponse
}

public struct GetGenreUseCase {

    @Injected(\.moviesRepository) var repository

    public init() {}
}

extension GetGenreUseCase: GetGenreUseCaseProtocol {

    public func callAsFunction(_ id: Int) async throws -> GenreResponse {
        try await repository.getGenre(id)
    }
}

extension Container {

    public var getGenreUseCase: Factory<GetGenreUseCaseProtocol> {
        self { GetGenreUseCase() }
    }
}
