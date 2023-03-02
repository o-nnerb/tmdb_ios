//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import CoreApp
import CoreScene

@MainActor
protocol MoviesViewModelling: ViewModelling {

    var query: String { get set }
    var items: [Movie] { get }
    var isLoading: Bool { get }

    func loadData()
    func loadNextPageIfNeeded(_ model: Movie)

    func submit(_ model: Movie)
}
