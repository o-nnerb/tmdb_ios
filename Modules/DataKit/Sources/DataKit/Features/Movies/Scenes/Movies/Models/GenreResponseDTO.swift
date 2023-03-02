//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import CoreKit

public struct GenreResponseDTO: Codable {

    public let id: Int
    public let name: String
}

extension GenreResponseDTO {

    public var toDomain: GenreResponse {
        .init(
            id: id,
            name: name
        )
    }
}
