//
//  DomainAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SuperKit
import Factory
import MoviesDomain

struct DomainAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

// MARK: - App
extension DomainAssembly {

    func assembleMovies(_ container: Container) {

        container.getPhotoUseCase.register {
            GetPhotoUseCase()
        }

        container.getGenreUseCase.register {
            GetGenreUseCase()
        }

        container.getMovieUseCase.register {
            GetMovieUseCase()
        }

        container.getUpcomingMoviesUseCase.register {
            GetUpcomingMoviesUseCase()
        }
    }
}
