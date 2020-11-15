//
//  APIError.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation

struct APIError: Decodable, Error {
    let statusCode: Int
    let statusMessage: String
    let wasSuccess: Bool

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
        self.wasSuccess = try container.decodeIfPresent(Bool.self, forKey: .wasSuccess) ?? true
    }
}

extension APIError {
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case wasSuccess = "success"
    }
}
