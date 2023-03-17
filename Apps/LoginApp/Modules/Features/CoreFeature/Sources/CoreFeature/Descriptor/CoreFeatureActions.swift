//
//  File.swift
//  
//
//  Created by Brenno on 16/03/23.
//

import SwiftUI
import NavigationKit
import LoginScenes

public struct CoreFeatureActions: FeatureActions {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .sceneActionTransformer(for: CoreFeatureAction.self) {
                switch $1 {
                case .error(let failure):
                    $0(failure)
                }
            }
    }
}
