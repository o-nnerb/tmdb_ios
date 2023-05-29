//
//  SuperAppApp.swift
//  SuperApp
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import SuperKit
import Factory
import LoginApp
import MoviesApp

@main
struct SuperApp: SwiftUI.App {

    init() {
        register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .viewResolver(for: LoginAppScene.self) {
                    LoginAppResolver($0)
                }
                .viewResolver(for: MoviesAppScene.self) {
                    MoviesAppResolver($0)
                }
        }
    }
}

extension SuperApp {

    @MainActor
    func register() {
        LoginApp.start()
        MoviesApp.start()

        Container.shared.navigationBuilder.register {
            NavigationBuilder()
        }
    }
}
