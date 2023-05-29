//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import Factory
import CoreFeature

public struct LoginAppResolver: AppResolver {

    @Injected(\.navigationBuilder) var navigationFactory

    private let scene: LoginAppScene

    public init(_ scene: LoginAppScene) {
        self.scene = scene
    }

    public var body: some View {
        switch scene {
        case .none:
            navigationFactory {
                EmptyView()
            }
        }
    }
}
