//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import Foundation

extension JSONDecoder {

    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "YYYY/MM/dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }
}
