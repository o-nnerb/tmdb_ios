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
            .sceneActionTransformer(for: LoginAppAction.self) {
                switch $1 {
                case .error(let error):
                    $0(error)
                }
            }
            .modifier(CoreFeatureActions())
    }
}
