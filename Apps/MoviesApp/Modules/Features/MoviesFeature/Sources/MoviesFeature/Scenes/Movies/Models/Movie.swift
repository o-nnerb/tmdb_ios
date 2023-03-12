//
//  File.swift
//  
//
//  Created by Brenno on 16/02/23.
//

import Foundation
import MoviesDomain

struct Movie: Hashable {

    private let model: MovieResponse

    init(_ model: MovieResponse) {
        self.model = model
    }
}

extension Movie: Identifiable {

    var id: Int {
        model.id
    }
}

extension Movie {

    var posterPath: String? {
        model.posterPath
    }

    var name: String {
        model.title
    }

    var genreID: Int? {
        model.genresIDs.first
    }

    var votesAverage: Double {
        model.votesAverage
    }

    var votesCount: Int {
        model.votesCount
    }

    var releaseDate: Date {
        model.releaseDate
    }
}

extension Movie {

    var toDomain: MovieResponse {
        model
    }
}
