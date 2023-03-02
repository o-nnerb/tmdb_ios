//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI
import NavigationKit
import CoreApp
import CoreScene
import Injection
import CoreKit

@MainActor
struct MovieCoordinator: Coordinator {

    @Environment(\.navigationAction) var navigationAction
    @Environment(\.sceneAction) var sceneAction

    private let scene: MovieScene

    init(_ scene: MovieScene) {
        self.scene = scene
    }

    var body: some View {
        ViewModelConnection(scene, MovieViewModel.init) { viewModel in
            MovieView(viewModel: viewModel)
                .onReceive(viewModel.$destination) {
                    switch $0 {
                    case .back:
                        backScene()
                    case .error(let error):
                        errorAction(error)
                    case .none:
                        break
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
        sceneAction(ErrorAction(error, at: .navigation(navigationAction)))
    }
}
