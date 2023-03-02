//
//  CoreNetworkAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Injection
import DataKit
import CoreNetwork

struct CoreNetworkAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension CoreNetworkAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            CoreNetwork.MoviesRemoteDataSource.init,
            forKey: DataKit.MoviesRemoteDataSource.self
        )
    }
}
