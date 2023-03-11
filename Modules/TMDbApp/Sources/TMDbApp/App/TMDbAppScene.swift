//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import Foundation
import CoreScene

public enum TMDbAppScene {
    case app(AppFeatureScene)
    case movies(MoviesFeatureScene)
}

extension TMDbAppScene: Hashable {

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .app(let scene):
            scene.hash(into: &hasher)
        case .movies(let scene):
            scene.hash(into: &hasher)
        }
    }
}

extension TMDbAppScene {

    public static var start: TMDbAppScene {
        .movies(MoviesFeatureScene.movies(
            MoviesFeatureScene.Movies()
        ))
    }
}
