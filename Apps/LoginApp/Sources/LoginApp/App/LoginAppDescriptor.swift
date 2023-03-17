//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import SuperKit
import NavigationKit
import CoreFeature

public struct LoginAppDescriptor: AppDescriptor {

    public init() {}

    public func body(content: Content) -> some View {
        content
            .modifier(CoreFeatureDescriptor())
    }
}


