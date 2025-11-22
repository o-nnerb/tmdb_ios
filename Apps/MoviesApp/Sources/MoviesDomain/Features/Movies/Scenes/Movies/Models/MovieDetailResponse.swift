//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation

public struct MovieDetailResponse: Hashable, Sendable {

    public let id: Int

    public let posterPath: String?
    public let backdropPath: String?

    public let title: String
    public let overview: String?

    public let productionCompanies: [String]
    public let isAdult: Bool

    public let releaseDate: Date
    public let votesAverage: Double
    public let votesCount: Int

    public let genres: [String]

    public init(
        id: Int,
        posterPath: String?,
        backdropPath: String?,
        title: String,
        overview: String?,
        productionCompanies: [String],
        isAdult: Bool,
        releaseDate: Date,
        votesAverage: Double,
        votesCount: Int,
        genres: [String]
    ) {
        self.id = id
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.title = title
        self.overview = overview
        self.productionCompanies = productionCompanies
        self.isAdult = isAdult
        self.releaseDate = releaseDate
        self.votesAverage = votesAverage
        self.votesCount = votesCount
        self.genres = genres
    }
}
