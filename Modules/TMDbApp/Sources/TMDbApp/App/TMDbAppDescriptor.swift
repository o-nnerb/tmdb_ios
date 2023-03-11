//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import CoreScene
import NavigationKit
import AppFeature
import MoviesFeature

public struct TMDbAppDescriptor: FeatureDescriptor {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .modifier(AppFeatureDescriptor())
            .modifier(MoviesFeatureDescriptor())
    }
}


