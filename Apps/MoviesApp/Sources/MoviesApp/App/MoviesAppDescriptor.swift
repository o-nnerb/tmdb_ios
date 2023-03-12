//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import MoviesFeature

public struct MoviesAppDescriptor: AppDescriptor {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .navigationDestinationTransformer(for: MoviesAppScene.self) { transformer, scene in
                switch scene {
                case .movies(let scene):
                    transformer(scene)
                }
            }
            .modifier(MoviesFeatureDescriptor())
    }
}


