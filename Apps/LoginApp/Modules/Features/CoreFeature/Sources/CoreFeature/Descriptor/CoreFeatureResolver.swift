//
//  MoviesFeatureResolver.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import LoginScenes
import NavigationKit

public struct CoreFeatureResolver: FeatureResolver {

    private let scene: CoreFeatureScene

    public init(_ scene: CoreFeatureScene) {
        self.scene = scene
    }

    public var body: some View {
        switch scene {
        case .none:
            EmptyView()
        }
    }
}
