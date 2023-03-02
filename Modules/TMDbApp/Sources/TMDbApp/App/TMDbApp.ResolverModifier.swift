//
//  PantryApp.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SwiftUI
import CoreApp
import CoreScene
import MoviesFeature

public extension TMDbApp {

    struct ResolverModifier: ViewModifier {

        public func body(content: Content) -> some View {
            content
                .viewResolver(for: MoviesFeatureScene.self) {
                    MoviesFeatureDescriptor($0)
                }
        }
    }
}
