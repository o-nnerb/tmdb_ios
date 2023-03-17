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
            .sceneActionMap(for: CoreFeatureAction.self) { action -> ErrorAction in
                switch action {
                case .error(let failure):
                    return failure
                }
            }
    }
}
