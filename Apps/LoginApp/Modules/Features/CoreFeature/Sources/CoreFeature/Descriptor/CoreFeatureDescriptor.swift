//
//  MoviesFeatureDescriptor.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import NavigationKit
import LoginScenes

public struct CoreFeatureDescriptor: FeatureDescriptor {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .modifier(ErrorViewModifier())
    }
}
