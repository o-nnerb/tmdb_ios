//
//  File.swift
//  
//
//  Created by Brenno on 18/02/23.
//

import Foundation
import MoviesDomain

enum MoviesDestination {
    case submit(MovieResponse)
    case error(Error)
}
