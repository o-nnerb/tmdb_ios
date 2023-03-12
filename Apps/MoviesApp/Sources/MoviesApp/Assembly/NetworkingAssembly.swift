//
//  CoreNetworkAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SuperKit
import Injection
import MoviesData
import MoviesNetworking

struct NetworkingAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension NetworkingAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            MoviesNetworking.MoviesRemoteDataSource.init,
            forKey: MoviesData.MoviesRemoteDataSource.self
        )
    }
}
