//
//  NavigationBuilder.swift
//  MoviesSampleApp
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import Injection
import SuperUI
import LoginApp

struct NavigationBuilder: SuperKit.NavigationBuilder {

    func callAsFunction<Content: View>(
        content: @escaping () -> Content
    ) -> AnyView {
        NKNavigationStack {
            content()
                .modifier(LoginAppActions())
                .modifier(LoginAppDescriptor())
        }
        .eraseToAnyView()
    }
}
