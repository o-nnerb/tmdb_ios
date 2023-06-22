//
//  File.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import Foundation
import MoviesScenes
import ComposableArchitecture

typealias MoviesScene = MoviesFeatureScene.Movies

extension MoviesScene {

    var store: StoreOf<MoviesReducer> {
        .init(
            initialState: .init(),
            reducer: MoviesReducer()
        )
    }
}
