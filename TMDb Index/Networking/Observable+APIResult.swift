//
//  Observable+APIResult.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import Moya
import RxSwift
import RxMoya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func apiMap<Object>(_ objectType: Object.Type) -> Single<APIResult<Object>> where Object: Decodable {
        self.map { response in
            do {
                return .success(try response.map(Object.self))
            } catch let error {
                return .error(error)
            }
        }
        .catchError {
            if let errorResponse = ($0 as? MoyaError)?.response {
                return .error(try errorResponse.map(APIError.self))
            }

            return .error($0)
        }
    }
}
