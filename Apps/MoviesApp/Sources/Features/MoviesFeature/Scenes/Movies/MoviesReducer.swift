//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import NavigationKit
import ComposableArchitecture
import Factory
import SuperKit
import MoviesDomain
import MoviesScenes

@Reducer
struct MoviesReducer: Reducer {

    @Injected(\.getUpcomingMoviesUseCase) var getUpcomingMoviesUseCase

    @ObservableState
    struct State: Hashable {
        var query: String = ""
        fileprivate var _items: [Movie] = []
        var isLoading = false

        fileprivate var page: Int = .zero
        fileprivate var canLoadMorePages = true

        let transaction = SceneTransaction<MoviesDestination>()
    }

    @ObservableState
    enum Action {
        case loadData
        case loadNextPageIfNeeded(Movie)
        case submit(Movie)

        case queryChanged(String)

        case error(Error, CancelID?)

        case loadPage(Int)
        case appendPage([Movie], Int)
    }

    enum CancelID {
        case upcomingMovies
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadData:
                guard state.canLoadMorePages && state.items.isEmpty else {
                    break
                }

                state.page = .zero
                return .send(.loadPage(1))

            case .loadNextPageIfNeeded(let model):
                guard
                    state.query.isEmpty,
                    state.canLoadMorePages,
                    !state.isLoading,
                    let index = state.items.firstIndex(where: { $0.id == model.id })
                else { break }

                let thresholdIndex = state.items.index(state.items.endIndex, offsetBy: -5)

                if index < thresholdIndex {
                    break
                }
                return .send(.loadPage(state.page + 1))
            case .submit(let model):
                state.transaction(.submit(model.toDomain))

            case .queryChanged(let query):
                state.query = query

            case .error(let error, let cancelID):
                state.transaction(.error(error))

                switch cancelID {
                case .upcomingMovies:
                    state.canLoadMorePages = false
                    state.isLoading = false
                case .none:
                    break
                }

            case .appendPage(let movies, let page):
                state.isLoading = false
                state.page = page
                state.canLoadMorePages = movies.count == 20
                state._items.append(contentsOf: movies)

            case .loadPage(let page):
                state.isLoading = true

                return .run { [getUpcomingMoviesUseCase] send in
                    do {
                        let items = try await getUpcomingMoviesUseCase(at: page)
                        await send(.appendPage(items.map { .init($0) }, page))
                    } catch {
                        await send(.error(error, CancelID.upcomingMovies))
                    }
                }.cancellable(id: CancelID.upcomingMovies, cancelInFlight: true)
            }

            return .none
        }
    }
}

extension MoviesReducer.State {

    var items: [Movie] {
        query.isEmpty ? _items : _items.filter {
            $0.name.contains(query)
        }
    }
}
