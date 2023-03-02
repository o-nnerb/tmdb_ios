//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import CoreApp
import CoreKit
import Injection
import CoreScene

class MoviesViewModel: ViewModel<MoviesDestination> {

    @Injected var getUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol

    @Published var query: String = ""
    @Published var _items: [Movie] = []
    @Published var isLoading: Bool = false

    private var page: Int = .zero
    private var canLoadMorePages = true

    init(_ scene: MoviesScene) {
        super.init()
    }

    override func setBindings() {
        super.setBindings()
        
    }
}

extension MoviesViewModel: MoviesViewModelling {

    var items: [Movie] {
        query.isEmpty ? _items : _items.filter {
            $0.name.contains(query)
        }
    }

    func submit(_ model: Movie) {
        destination = .submit(model.toDomain)
    }

    func loadData() {
        guard canLoadMorePages && items.isEmpty else {
            return
        }

        Task {
            page = .zero
            isLoading = true

            _items = await loadPage(page).map {
                .init($0)
            }

            isLoading = false
        }
    }

    func loadNextPageIfNeeded(_ model: Movie) {
        guard
            canLoadMorePages,
            !isLoading,
            let index = items.firstIndex(where: { $0.id == model.id }),
            query.isEmpty
        else { return }

        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)

        if index < thresholdIndex {
            return
        }

        Task {
            isLoading = true

            await _items.append(contentsOf: loadPage(page).map {
                .init($0)
            })

            isLoading = false
        }
    }
}

extension MoviesViewModel {

    func loadPage(_ page: Int) async -> [MovieResponse] {
        var items = [MovieResponse]()

        do {
            items = try await getUpcomingMoviesUseCase(at: page + 1)
        } catch {
            destination = .error(error)
        }

        canLoadMorePages = items.count == 20
        self.page += 1

        return items
    }
}
