//
//  File.swift
//  
//
//  Created by Brenno on 24/02/23.
//

import SwiftUI
import NavigationKit

@MainActor
public protocol FeatureDescriptor: View {

    associatedtype Scene: Hashable

    associatedtype Destinations: FeatureDescriptorDestinations

    init(_ scene: Scene)
}

@MainActor
extension View {

    @ViewBuilder
    public func featureDescriptor<Descriptor: FeatureDescriptor>(
        _ descriptor: Descriptor.Type
    ) -> some View {
        self
            .modifier(Descriptor.Destinations())
            .navigationDestination(for: Descriptor.Scene.self) {
                Descriptor($0)
            }
    }
}
