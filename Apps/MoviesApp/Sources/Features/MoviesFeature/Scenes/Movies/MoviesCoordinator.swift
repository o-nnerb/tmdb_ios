//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import NavigationKit
import ComposableArchitecture
import Factory
import SuperKit
import MoviesDomain
import MoviesScenes

@MainActor
struct MoviesCoordinator: Coordinator {

    @Environment(\.navigationAction) var navigationAction
    @Environment(\.sceneAction) var sceneAction

    private let scene: MoviesScene

    init(_ scene: MoviesScene) {
        self.scene = scene
    }

    var body: some View {
        ObjectConnection(scene, { $0.store }) { store in
            WithPerceptionTracking {
                MoviesView(store: store)
                    .onReceive(store.transaction.publisher) {
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
}

private extension MoviesCoordinator {

    func errorAction(_ error: Error) {
        sceneAction(LoginAppAction.error(
            LoginAppAction.Failure(error, at: .navigation(navigationAction))
        ))
    }

    func submitScene(_ movie: MovieResponse) {
        navigationAction.append(
            MovieScene(movie: movie)
        )
    }
}
