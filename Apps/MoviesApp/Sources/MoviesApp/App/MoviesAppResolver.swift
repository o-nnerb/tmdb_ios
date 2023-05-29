//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import Factory
import MoviesFeature

public struct MoviesAppResolver: AppResolver {

    @Injected(\.navigationBuilder) var navigationFactory

    private let scene: MoviesAppScene

    public init(_ scene: MoviesAppScene) {
        self.scene = scene
    }

    public var body: some View {
        switch scene {
        case .movies(let scene):
            navigationFactory {
                MoviesFeatureResolver(.movies(scene))
            }
        }
    }
}
