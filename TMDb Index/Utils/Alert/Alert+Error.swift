//
//  Alert+APIError.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import Moya

extension Alert {
    func error(_ error: Error) -> Self {
        switch error {
        case let apiError as APIError:
            return self.message(apiError.statusMessage)
        case is DecodingError:
            return self.message("Error ao processar os dados")
        case let moyaError as MoyaError:
            return self.message(moyaError.failureReason ?? moyaError.localizedDescription)
        default:
            return self.message(error.localizedDescription)
        }
    }
}
