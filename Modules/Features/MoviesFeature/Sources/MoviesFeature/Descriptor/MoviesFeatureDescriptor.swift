//
//  MoviesFeatureDescriptor.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import NavigationKit
import CoreScene

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
    }
}
