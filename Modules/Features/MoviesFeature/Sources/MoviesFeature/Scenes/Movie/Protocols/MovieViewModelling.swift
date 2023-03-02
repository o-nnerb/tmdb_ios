//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI
import CoreApp
import CoreScene

@MainActor
protocol MovieViewModelling: ViewModelling {

    var movie: MovieDetail { get }
    var poster: CGImage? { get }
    var backdrop: CGImage? { get }

    var isMovieLoading: Bool { get }
    var isPosterLoading: Bool { get }
    var isBackdropLoading: Bool { get }

    func loadData()
    func back()
}
