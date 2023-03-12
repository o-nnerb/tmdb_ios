//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import NavigationKit

public enum SceneAnchor {
    case navigation(NavigationAction)
    case dismiss(DismissAction)
}

extension SceneAnchor {

    fileprivate enum RawValue {
        case navigationAction
        case dismissAction
    }

    fileprivate var rawValue: RawValue {
        switch self {
        case .navigation:
            return .navigationAction
        case .dismiss:
            return .dismissAction
        }
    }
}

extension SceneAnchor: Hashable {

    public static func == (_ lhs: SceneAnchor, _ rhs: SceneAnchor) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}
