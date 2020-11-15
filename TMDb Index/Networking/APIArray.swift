//
//  APIArray.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation

struct APIArray<Element>: Decodable where Element: Decodable {
    let page: Int
    let results: [Element]
    let totalPages: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
        self.results = try container.decode([Element].self, forKey: .results)
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 1
    }
}

extension APIArray {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
