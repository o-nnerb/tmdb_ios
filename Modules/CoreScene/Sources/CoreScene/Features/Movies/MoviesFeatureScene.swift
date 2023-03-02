//
//  File.swift
//  
//
//  Created by Brenno on 17/02/23.
//

import Foundation
import CoreApp
import CoreKit

public enum MoviesFeatureScene {
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

    public struct Movies: Hashable {

        public init() {}
    }
}
