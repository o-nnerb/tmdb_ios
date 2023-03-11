//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import CoreApp
import CoreKit

enum MovieDestination {
    case back
    case error(Error)
}

extension MovieDestination: Equatable {

    static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.back, .back):
            return true
        case (.error(let lhs), .error(let rhs)):
            return "\(type(of: lhs))" == "\(type(of: rhs))" && {
                lhs.localizedDescription == rhs.localizedDescription
            }()
        default:
            return false
        }
    }
}

extension MovieDestination: Hashable {

    private enum RawDestination: Hashable {
        case back
        case error
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .back:
            hasher.combine(RawDestination.back)
        case .error(let error):
            hasher.combine(RawDestination.error)
            hasher.combine("\(type(of: error))")
            hasher.combine(error.localizedDescription)
        }
    }
}
