//
//  ErrorSceneProtocol.swift
//  
//
//  Created by Brenno Giovanini de Moura on 03/11/22.
//

import SwiftUI
import NavigationKit

public struct ErrorAction {

    public let error: Error
    public let anchor: Anchor?

    public init(_ error: Error, at anchor: Anchor? = nil) {
        self.error = error
        self.anchor = anchor
    }
}

extension ErrorAction {

    public enum Anchor {
        case navigation(NavigationAction)
    }
}

extension ErrorAction: Equatable {

    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        guard type(of: lhs.error) == type(of: rhs.error) else {
            return false
        }

        return lhs.error.localizedDescription == rhs.error.localizedDescription
    }
}

extension ErrorAction: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(type(of: error))")
        hasher.combine(error.localizedDescription)
    }
}
