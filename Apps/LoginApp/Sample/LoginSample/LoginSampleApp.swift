//
//  MoviesSampleAppApp.swift
//  MoviesSampleApp
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import LoginApp
import Factory
import SuperKit

@main
struct MoviesSampleApp: SwiftUI.App {

    init() {
        Self.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .viewResolver(for: LoginAppScene.self) {
                    LoginAppResolver($0)
                }
                .sceneActionEnabled()
        }
    }
}

extension MoviesSampleApp {

    @MainActor
    static func start() {
        LoginApp.start()

        Container.shared.navigationBuilder.register {
            NavigationBuilder()
        }
    }
}
