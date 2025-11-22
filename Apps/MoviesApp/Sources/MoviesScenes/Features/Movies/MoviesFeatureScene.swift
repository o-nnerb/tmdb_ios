//
//  File.swift
//  
//
//  Created by Brenno on 17/02/23.
//

import Foundation
import SuperKit
import MoviesDomain

public enum MoviesFeatureScene: Sendable {
    case movies(Movies)
}

extension MoviesFeatureScene: Hashable {

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .movies(let scene):
            scene.hash(into: &hasher)
        }
    }
}

extension MoviesFeatureScene {

    public typealias Movies = MoviesAppScene.Movies
}
