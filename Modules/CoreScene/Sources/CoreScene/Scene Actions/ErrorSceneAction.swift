//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import Foundation
import NavigationKit

public struct ErrorSceneAction: Hashable {

    public let scene: AppFeatureScene.Error

    public init(_ scene: AppFeatureScene.Error) {
        self.scene = scene
    }
}
