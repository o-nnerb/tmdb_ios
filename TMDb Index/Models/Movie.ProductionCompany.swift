//
//  Movie.ProductionCompany.swift
//  TMDb Index
//
//  Created by brennobemoura on 15/11/20.
//

import Foundation

extension Movie {
    struct ProductionCompany: Decodable {
        let id: Int
        let name: String
    }
}
