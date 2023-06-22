//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import MoviesDomain

public struct MovieDetailResponseDTO: Decodable {

    public let id: Int

    public let posterPath: String?
    public let backdropPath: String?

    public let title: String
    public let overview: String?

    public let productionCompanies: [CompanyResponseDTO]
    public let isAdult: Bool

    public let releaseDate: Date
    public let votesAverage: Double
    public let votesCount: Int

    public let genres: [GenreResponseDTO]
}

extension MovieDetailResponseDTO {

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case overview
        case isAdult = "adult"
        case releaseDate = "release_date"
        case votesAverage = "vote_average"
        case votesCount = "vote_count"
        case productionCompanies = "production_companies"
        case genres = "genres"
    }
}

extension MovieDetailResponseDTO {

    public var toDomain: MovieDetailResponse {
        .init(
            id: id,
            posterPath: posterPath,
            backdropPath: backdropPath,
            title: title,
            overview: overview,
            productionCompanies: productionCompanies.map(\.name),
            isAdult: isAdult,
            releaseDate: releaseDate,
            votesAverage: votesAverage,
            votesCount: votesCount,
            genres: genres.map(\.name)
        )
    }
}
