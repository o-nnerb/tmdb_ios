//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import NavigationKit

public protocol NavigationBuilder {

    @MainActor
    func callAsFunction<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) -> AnyView
}
