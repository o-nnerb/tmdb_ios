//
//  File.swift
//  TMDb Index
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import CoreScene
import NavigationKit
import TMDbApp

struct NavigationFactory: CoreScene.NavigationFactory {

    func callAsFunction<Content>(
        @ViewBuilder content: @escaping () -> Content
    ) -> NKNavigationStack<AnyView> where Content : View {
        NKNavigationStack {
            AnyView(
                content()
                    .modifier(TMDbAppDescriptor())
            )
        }
    }
}
