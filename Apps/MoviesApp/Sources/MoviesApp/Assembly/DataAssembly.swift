//
//  DataAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Injection
import MoviesDomain
import MoviesData

struct DataAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension DataAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            MoviesRepository.init,
            forKey: MoviesRepositoryProtocol.self
        )
    }
}
