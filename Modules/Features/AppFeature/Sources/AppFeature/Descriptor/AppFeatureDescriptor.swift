//
//  File.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import CoreScene
import NavigationKit

public struct AppFeatureDescriptor: ViewModifier {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .modifier(ErrorViewModifier())
    }
}
