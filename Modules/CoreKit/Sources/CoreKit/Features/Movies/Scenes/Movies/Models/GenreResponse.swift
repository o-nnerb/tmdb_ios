//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation

public struct GenreResponse {

    public let id: Int
    public let name: String

    public init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
