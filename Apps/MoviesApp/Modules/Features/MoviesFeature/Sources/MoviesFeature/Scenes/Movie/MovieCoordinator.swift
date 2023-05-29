//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI
import NavigationKit
import ComposableArchitecture
import Factory
import SuperKit
import MoviesDomain
import MoviesScenes

@MainActor
struct MovieCoordinator: Coordinator {

    @Environment(\.navigationAction) var navigationAction
    @Environment(\.sceneAction) var sceneAction

    private let scene: MovieScene

    init(_ scene: MovieScene) {
        self.scene = scene
    }

    var body: some View {
        ObjectConnection(scene, \.store) {
            WithViewStore($0) {
                MovieView(viewStore: $0)
                    .onReceive($0.transaction.publisher) {
                        switch $0 {
                        case .back:
                            backScene()
                        case .error(let error):
                            errorAction(error)
                        }
                    }
            }
        }
    }
}

private extension MovieCoordinator {

    func backScene() {
        navigationAction.removeIncluding(scene)
    }

    func errorAction(_ error: Error) {
        sceneAction(LoginAppAction.error(
            LoginAppAction.Failure(error, at: .navigation(navigationAction))
        ))
    }
}
