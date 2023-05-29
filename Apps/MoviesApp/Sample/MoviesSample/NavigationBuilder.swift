//
//  NavigationBuilder.swift
//  MoviesSampleApp
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import Factory
import SuperUI
import MoviesApp

struct NavigationBuilder: SuperKit.NavigationBuilder {

    func callAsFunction<Content: View>(
        content: @escaping () -> Content
    ) -> AnyView {
        NKNavigationStack {
            content()
                .modifier(MoviesAppActions())
                .modifier(MoviesAppDescriptor())
        }
        .eraseToAnyView()
    }
}
