//
//  MovieViewModel.swift
//  TMDb Index
//
//  Created by brennobemoura on 15/11/20.
//

import Foundation
import RxCocoa
import RxSwift

class MovieViewModel {

    let activityIndicator = ActivityIndicator()
    let movieRelay: BehaviorRelay<Movie>

    init(_ movie: Movie) {
        movieRelay = .init(value: movie)
    }
}

extension MovieViewModel {
    var movieRequest: Observable<APIResult<Movie>> {
        TMDbAPI.shared.request(.movie(movieRelay.value.id))
            .filterSuccessfulStatusAndRedirectCodes()
            .apiMap(Movie.self)
            .trackActivity(activityIndicator)
            .do(onNext: { [weak self] in
                if case .success(let movie) = $0 {
                    self?.movieRelay.accept(movie)
                }
            })
    }
}
