//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import Foundation
import SuperKit

public enum CoreFeatureAction {
    case error(Failure)
}

extension CoreFeatureAction: Hashable {

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .error(let failure):
            failure.hash(into: &hasher)
        }
    }
}

extension CoreFeatureAction {

    public typealias Failure = LoginAppAction.Failure
}
