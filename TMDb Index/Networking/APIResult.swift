//
//  APIResult.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation

enum APIResult<Element> where Element: Decodable {
    case success(Element)
    case error(Error)
}
