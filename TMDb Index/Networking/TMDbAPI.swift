//
//  TMDbAPI.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import Moya
import RxMoya
import RxSwift

struct TMDbAPI {
    static let shared = TMDbAPI()
    private let provider = MoyaProvider<Endpoint>()

    static let basePath = "https://api.themoviedb.org/3"
    static let token = "c5850ed73901b8d268d0898a8a9d8bff"
    static let imagesPath = "https://image.tmdb.org/t/p/w500"

    func request(_ endpoint: Endpoint) -> Single<Response> {
        provider.rx.request(endpoint)
    }
}
