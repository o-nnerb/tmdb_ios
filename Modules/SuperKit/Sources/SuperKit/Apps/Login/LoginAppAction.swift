//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import Foundation

public enum LoginAppAction: Hashable {
    case error(Failure)
}

extension LoginAppAction {

    public struct Failure: Hashable {

        public let error: HashableError<Error>
        public let anchor: SceneAnchor?

        public init(_ error: Error, at anchor: SceneAnchor? = nil) {
            self.error = .init(error)
            self.anchor = anchor
        }
    }
}
