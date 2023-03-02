//
//  File.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import CoreScene
import MoviesFeature

struct FeaturesModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .featureDescriptor(MoviesFeatureDescriptor.self)
    }
}
