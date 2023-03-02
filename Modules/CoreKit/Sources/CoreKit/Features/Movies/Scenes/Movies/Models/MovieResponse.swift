//
//  File.swift
//  
//
//  Created by Brenno on 21/02/23.
//

import Foundation

public struct MovieResponse: Hashable {

    public let id: Int
    public let posterPath: String?
    public let backdropPath: String?
    public let title: String
    public let isAdult: Bool
    public let releaseDate: Date
    public let votesAverage: Double
    public let votesCount: Int
    public let genresIDs: [Int]

    public init(
        id: Int,
        posterPath: String?,
        backdropPath: String?,
        title: String,
        isAdult: Bool,
        releaseDate: Date,
        votesAverage: Double,
        votesCount: Int,
        genresIDs: [Int]
    ) {
        self.id = id
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.title = title
        self.isAdult = isAdult
        self.releaseDate = releaseDate
        self.votesAverage = votesAverage
        self.votesCount = votesCount
        self.genresIDs = genresIDs
    }
}
