//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import LoginScenes
import CoreFeature

public struct LoginAppActions: AppActions {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .sceneActionMap(for: LoginAppAction.self) { action -> CoreFeatureAction in
                switch action {
                case .error(let error):
                    return CoreFeatureAction.error(error)
                }
            }
            .modifier(CoreFeatureActions())
    }
}
