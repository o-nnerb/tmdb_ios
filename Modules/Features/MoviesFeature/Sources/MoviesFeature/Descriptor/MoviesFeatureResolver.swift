//
//  MoviesFeatureResolver.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import CoreScene
import NavigationKit

public struct MoviesFeatureResolver: FeatureResolver {

    private let scene: MoviesFeatureScene

    public init(_ scene: MoviesFeatureScene) {
        self.scene = scene
    }

    public var body: some View {
        switch scene {
        case .movies(let scene):
            MoviesCoordinator(scene)
        }
    }
}
