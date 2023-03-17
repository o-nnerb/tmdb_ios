//
//  NavigationBuilder.swift
//  SuperApp
//
//  Created by Brenno on 16/03/23.
//

import SwiftUI
import NavigationKit
import Injection
import SuperKit
import SuperUI
import LoginApp
import MoviesApp

struct NavigationBuilder: SuperKit.NavigationBuilder {

    func callAsFunction<Content: View>(
        content: @escaping () -> Content
    ) -> AnyView {
        NKNavigationStack {
            content()
                .modifier(LoginAppActions())
                .modifier(LoginAppDescriptor())
                .modifier(MoviesAppActions())
                .modifier(MoviesAppDescriptor())
        }
        .eraseToAnyView()
    }
}
