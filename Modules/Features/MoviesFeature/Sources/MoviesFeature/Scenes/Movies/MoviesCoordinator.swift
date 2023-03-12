//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import NavigationKit
import CoreApp
import CoreScene
import Injection
import CoreKit
import ComposableArchitecture

@MainActor
struct MoviesCoordinator: Coordinator {

    @Environment(\.navigationAction) var navigationAction
    @Environment(\.sceneAction) var sceneAction

    private let scene: MoviesScene

    init(_ scene: MoviesScene) {
        self.scene = scene
    }

    var body: some View {
        WithViewStore(scene.store) { viewStore in
            MoviesView(viewStore: viewStore)
                .onReceive(viewStore.transaction.publisher) {
                    switch $0 {
                    case .error(let error):
                        errorAction(error)
                    case .submit(let movie):
                        submitScene(movie)
                    }
                }
        }
    }
}

private extension MoviesCoordinator {

    func errorAction(_ error: Error) {
        sceneAction(ErrorSceneAction(
            AppFeatureScene.Error(error, at: .navigation(navigationAction))
        ))
    }

    func submitScene(_ movie: MovieResponse) {
        navigationAction.append(
            MovieScene(movie: movie)
        )
    }
}
