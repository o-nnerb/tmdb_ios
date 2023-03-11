//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import Foundation

public enum AppFeatureScene {
    case error(Error)
}

extension AppFeatureScene: Hashable {

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .error(let scene):
            scene.hash(into: &hasher)
        }
    }
}

extension AppFeatureScene {

    public struct Error: Hashable {

        public let error: Swift.Error
        public let anchor: DestinationAnchor?

        public init(_ error: Swift.Error, at anchor: DestinationAnchor? = nil) {
            self.error = error
            self.anchor = anchor
        }
    }
}

extension AppFeatureScene.Error {

    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        guard type(of: lhs.error) == type(of: rhs.error) else {
            return false
        }

        return lhs.error.localizedDescription == rhs.error.localizedDescription
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(type(of: error))")
        hasher.combine(error.localizedDescription)
    }
}
