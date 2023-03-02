//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import Foundation
import Injection
import DataKit
import CoreStorage

struct CoreStorageAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension CoreStorageAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            CoreStorage.MoviesLocalDataSource.init,
            forKey: DataKit.MoviesLocalDataSource.self
        )
    }
}
