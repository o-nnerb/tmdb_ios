//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import CoreScene
import NavigationKit
import AppFeature
import MoviesFeature

public struct TMDbAppDescriptor: FeatureDescriptor {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .navigationDestinationTransformer(for: TMDbAppScene.self) { transformer, scene in
                switch scene {
                case .movies(let scene):
                    transformer(scene)
                case .app:
                    break
                }
            }
            .modifier(AppFeatureDescriptor())
            .modifier(MoviesFeatureDescriptor())
    }
}


