//
//  PantryApp.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SwiftUI
import CoreApp
import CoreScene

@MainActor
public struct TMDbApp: View {

    public init() {
        Assembler.run([
            CoreKitAssembly(),
            DataKitAssembly(),
            CoreNetworkAssembly(),
            CoreStorageAssembly()
        ])
    }

    public var body: some View {
        ContentView()
            .modifier(ResolverModifier())
            .modifierResolver(for: CoreScene.FeatureModifiers.self) {
                FeaturesModifier()
            }
    }
}
