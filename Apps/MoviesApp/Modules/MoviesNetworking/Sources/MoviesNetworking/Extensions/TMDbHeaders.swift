//
//  File.swift
//  
//
//  Created by Brenno on 27/02/23.
//

import Foundation
import RequestDL

struct TMDbHeaders: Property {

    var body: some Property {
        AcceptHeader(.json)
        BaseURL("api.themoviedb.org")
        Path("3")
        Query(name: "api_key", value: "c5850ed73901b8d268d0898a8a9d8bff")
    }
}
