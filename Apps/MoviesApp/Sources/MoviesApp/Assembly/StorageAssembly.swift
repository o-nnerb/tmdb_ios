//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SuperKit
import Injection
import MoviesData
import MoviesStorage

struct StorageAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension StorageAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            MoviesStorage.MoviesLocalDataSource.init,
            forKey: MoviesData.MoviesLocalDataSource.self
        )
    }
}
