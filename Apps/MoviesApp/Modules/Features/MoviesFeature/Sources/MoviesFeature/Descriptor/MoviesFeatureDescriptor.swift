//
//  MoviesFeatureDescriptor.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import NavigationKit
import MoviesScenes

public struct MoviesFeatureDescriptor: FeatureDescriptor {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .navigationDestination(for: MovieScene.self) {
                MovieCoordinator($0)
            }
            .navigationDestination(for: MoviesScene.self) {
                MoviesCoordinator($0)
            }
            .navigationDestinationTransformer(for: MoviesFeatureScene.self) {
                switch $1 {
                case .movies(let scene):
                    $0(scene)
                }
            }
    }
}
