//
//  File.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import NavigationKit
import CoreScene

public struct AppFeatureResolver: FeatureResolver {

    private let scene: AppFeatureScene

    public init(_ scene: AppFeatureScene) {
        self.scene = scene
    }

    public var body: some View {
        switch scene {
        case .error:
            EmptyView()
        }
    }
}

