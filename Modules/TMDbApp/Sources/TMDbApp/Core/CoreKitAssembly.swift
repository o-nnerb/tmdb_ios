//
//  CoreKitAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Injection
import CoreKit

struct CoreKitAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

// MARK: - App
extension CoreKitAssembly {

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
