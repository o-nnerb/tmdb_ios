//
//  Movie.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation

struct Movie: Decodable {
    let id: Int

    let posterPath: String?
    let backdropPath: String?

    let title: String
    let overview: String?

    let productionCompanies: [ProductionCompany]
    let isAdult: Bool

    let releaseDate: Date
    let votes: (average: Double, count: Int)

    fileprivate let partialGenres: [PartialGenre]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)

        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)

        title = try container.decode(String.self, forKey: .title)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)

        productionCompanies = try container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies) ?? []
        isAdult = try container.decode(Bool.self, forKey: .isAdult)

        votes = (
            try container.decode(Double.self, forKey: .votesAverage),
            try container.decode(Int.self, forKey: .votesCount)
        )

        releaseDate = Date(try container.decode(String.self, forKey: .releaseDate))!

        if let genresId: [Int] = try container.decodeIfPresent([Int].self, forKey: .genresId) {
            partialGenres = genresId.map { .id($0) }
        } else {
            partialGenres = (try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []).map {
                .genre($0)
            }
        }
    }
}

extension Movie {
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

        case genresId = "genre_ids"
        case genres
    }
}

extension Movie {

    fileprivate enum PartialGenre {
        case id(Int)
        case genre(Genre)
    }

    var genres: [Genre] {
        partialGenres.compactMap {
            switch $0 {
            case .id(let id):
                return GenresService.shared.genres.first(where: { $0.id == id })
            case .genre(let genre):
                return genre
            }
        }
    }
}
