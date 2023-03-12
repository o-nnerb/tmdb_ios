//
//  File.swift
//  
//
//  Created by Brenno on 23/02/23.
//

import Foundation
import MoviesDomain
import MoviesScenes
import ComposableArchitecture

struct MovieScene: Hashable {
    let movie: MovieResponse
}

extension MovieScene {

    var store: Store<MovieReducer.State, MovieReducer.Action> {
        .init(
            initialState: .init(self),
            reducer: MovieReducer()
        )
    }
}
