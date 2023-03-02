//
//  File.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import CoreScene
import NavigationKit

extension TMDbApp {

    struct ContentView: View {

        @Environment(\.viewResolver) var viewResolver

        @State var error: ErrorAction?

        var body: some View {
            NKNavigationStack {
                viewResolver(MoviesFeatureScene.movies(.init()))
                    .modifier(for: CoreScene.FeatureModifiers.self)
            }
            .modifier(ErrorModifier(action: $error))
            .modifier(FeaturesActions())
            .sceneAction(for: ErrorAction.self) {
                error = $0
            }
            .sceneActionEnabled()
        }
    }
}
