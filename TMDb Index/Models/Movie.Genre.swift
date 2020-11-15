//
//  Movie.Genre.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation

extension Movie {
    struct Genre: Codable {
        let id: Int
        let name: String
    }
}
