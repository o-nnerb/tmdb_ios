//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import NavigationKit

public protocol NavigationFactory {

    @MainActor
    func callAsFunction<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) -> NKNavigationStack<AnyView>
}
