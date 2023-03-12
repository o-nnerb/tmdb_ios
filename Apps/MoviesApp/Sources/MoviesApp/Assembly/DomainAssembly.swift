//
//  DomainAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SuperKit
import Injection
import MoviesDomain

struct DomainAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

// MARK: - App
extension DomainAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            GetPhotoUseCase.init,
            forKey: GetPhotoUseCaseProtocol.self
        )

        container.register(
            GetGenreUseCase.init,
            forKey: GetGenreUseCaseProtocol.self
        )

        container.register(
            GetMovieUseCase.init,
            forKey: GetMovieUseCaseProtocol.self
        )

        container.register(
            GetUpcomingMoviesUseCase.init,
            forKey: GetUpcomingMoviesUseCaseProtocol.self
        )
    }
}
