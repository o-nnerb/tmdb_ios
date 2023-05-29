//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation
import Factory

public protocol MoviesLocalDataSource {

    func getGenre(_ id: Int) throws -> GenreResponseDTO

    func setGenres(_ genres: [GenreResponseDTO]) throws

    func setPhoto(_ image: Data, forPath path: String) throws

    func getPhoto(_ path: String) throws -> Data
}

extension Container {

    public var moviesLocalDataSource: Factory<MoviesLocalDataSource> {
        self { fatalError() }
    }
}
