//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import Foundation

public struct HashableError<Failure: Error> {

    public let error: Failure

    public init(_ error: Failure) {
        self.error = error
    }
}

extension HashableError: Equatable {

    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

extension HashableError: Hashable {

    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(Failure.self).hash(into: &hasher)
        hasher.combine(error.localizedDescription)
    }
}
