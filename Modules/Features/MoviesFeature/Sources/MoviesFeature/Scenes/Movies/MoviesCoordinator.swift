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

@MainActor
struct MoviesCoordinator: Coordinator {

    @Environment(\.navigationAction) var navigationAction
    @Environment(\.sceneAction) var sceneAction

    private let scene: MoviesScene

    init(_ scene: MoviesScene) {
        self.scene = scene
    }

    var body: some View {
        ViewModelConnection(scene, MoviesViewModel.init) { viewModel in
            MoviesView(viewModel: viewModel)
                .onReceive(viewModel.$destination) {
                    switch $0 {
                    case .error(let error):
                        errorAction(error)
                    case .submit(let movie):
                        submitScene(movie)
                    case .none:
                        break
                    }
                }
        }
    }
}

private extension MoviesCoordinator {

    func errorAction(_ error: Error) {
        sceneAction(ErrorAction(error))
    }

    func submitScene(_ movie: MovieResponse) {
        navigationAction.append(
            MovieScene(movie: movie)
        )
    }
}
