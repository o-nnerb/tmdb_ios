//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import Foundation
import CoreKit

struct MovieDetail: Hashable {

    private let origin: Origin

    init(_ model: MovieDetailResponse) {
        self.origin = .detail(model)
    }

    init(_ model: MovieResponse) {
        self.origin = .resumed(model)
    }
}

extension MovieDetail {

    enum Origin: Hashable {
        case detail(MovieDetailResponse)
        case resumed(MovieResponse)
    }

    func map<Value>(
        detail: KeyPath<MovieDetailResponse, Value>,
        resumed: KeyPath<MovieResponse, Value>
    ) -> Value {
        switch origin {
        case .detail(let model):
            return model[keyPath: detail]
        case .resumed(let model):
            return model[keyPath: resumed]
        }
    }
}

extension MovieDetail: Identifiable {

    var id: Int {
        map(detail: \.id, resumed: \.id)
    }
}

extension MovieDetail {

    var name: String {
        map(detail: \.title, resumed: \.title)
    }

    var votesAverage: Double {
        map(detail: \.votesAverage, resumed: \.votesAverage)
    }

    var votesCount: Int {
        map(detail: \.votesCount, resumed: \.votesCount)
    }

    var releaseDate: Date {
        map(detail: \.releaseDate, resumed: \.releaseDate)
    }

    var overview: String? {
        guard case .detail(let model) = origin else {
            return nil
        }

        return model.overview
    }

    var genre: String? {
        guard case .detail(let model) = origin else {
            return nil
        }

        return model.genres.first
    }

    var companies: String? {
        guard case .detail(let model) = origin else {
            return nil
        }

        return model.productionCompanies.joined(separator: ", ")
    }

    var backdropPath: String? {
        map(detail: \.backdropPath, resumed: \.backdropPath)
    }

    var posterPath: String? {
        map(detail: \.posterPath, resumed: \.posterPath)
    }
}
