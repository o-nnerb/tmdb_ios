//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import CoreScene
import NavigationKit
import Injection
import AppFeature
import MoviesFeature

public struct TMDbAppResolver: FeatureResolver {

    @Injected var navigationFactory: NavigationFactory

    private let scene: TMDbAppScene

    public init(_ scene: TMDbAppScene) {
        self.scene = scene
    }

    public var body: some View {
        switch scene {
        case .app(let scene):
            AppFeatureResolver(scene)
        case .movies(let scene):
            navigationFactory {
                MoviesFeatureResolver(scene)
            }
        }
    }
}
