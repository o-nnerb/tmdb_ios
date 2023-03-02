//
//  DataKitAssembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Injection
import CoreKit
import DataKit

struct DataKitAssembly: Assembly {

    func assemble(container: Container) {
        assembleMovies(container)
    }
}

extension DataKitAssembly {

    func assembleMovies(_ container: Container) {

        container.register(
            MoviesRepository.init,
            forKey: MoviesRepositoryProtocol.self
        )
    }
}
