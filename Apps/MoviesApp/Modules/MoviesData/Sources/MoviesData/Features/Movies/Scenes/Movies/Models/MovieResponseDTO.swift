//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation
import MoviesDomain

public struct MovieResponseDTO: Decodable {

    public let id: Int
    public let posterPath: String?
    public let backdropPath: String?
    public let title: String
    public let isAdult: Bool
    public let releaseDate: Date
    public let votesAverage: Double
    public let votesCount: Int
    public let genresIDs: [Int]
}

extension MovieResponseDTO {

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case isAdult = "adult"
        case releaseDate = "release_date"
        case votesAverage = "vote_average"
        case votesCount = "vote_count"
        case genresIDs = "genre_ids"
    }
}

extension MovieResponseDTO {

    public var toDomain: MovieResponse {
        .init(
            id: id,
            posterPath: posterPath,
            backdropPath: backdropPath,
            title: title,
            isAdult: isAdult,
            releaseDate: releaseDate,
            votesAverage: votesAverage,
            votesCount: votesCount,
            genresIDs: genresIDs
        )
    }
}
