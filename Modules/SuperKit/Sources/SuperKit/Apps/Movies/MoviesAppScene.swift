//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import Foundation

public enum MoviesAppScene: Sendable {
    case movies(Movies)
}

extension MoviesAppScene: Hashable {

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .movies(let scene):
            scene.hash(into: &hasher)
        }
    }
}

extension MoviesAppScene {

    public struct Movies: Hashable, Sendable {

        public init() {}
    }
}
