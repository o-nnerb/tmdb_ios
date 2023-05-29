//
//  DataAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Factory
import MoviesDomain
import MoviesData

struct DataAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension DataAssembly {

    func assembleMovies(_ container: Container) {

        container.moviesRepository.register {
            MoviesRepository()
        }
    }
}
