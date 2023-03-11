//
//  AppDelegate.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import SwiftUI
import TMDbApp
import Injection
import CoreScene

@main
struct SuperApp: App {

    init() {
        TMDbApp.start()
        start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .viewResolver(for: TMDbAppScene.self) {
                    TMDbAppResolver($0)
                }
                .sceneActionEnabled()
        }
    }
}

extension SuperApp {

    func start() {
        Container.shared.register(
            NavigationFactory.init,
            forKey: CoreScene.NavigationFactory.self
        )
    }
}
