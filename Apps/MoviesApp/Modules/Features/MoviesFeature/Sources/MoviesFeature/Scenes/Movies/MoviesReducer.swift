//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import NavigationKit
import ComposableArchitecture
import Injection
import SuperKit
import MoviesDomain
import MoviesScenes

struct MoviesReducer: ReducerProtocol {

    @Injected var getUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol

    struct State: Hashable {
        var query: String = ""
        fileprivate var _items: [Movie] = []
        var isLoading = false

        fileprivate var page: Int = .zero
        fileprivate var canLoadMorePages = true

        let transaction = SceneTransaction<MoviesDestination>()
    }

    enum Action {
        case loadData
        case loadNextPageIfNeeded(Movie)
        case submit(Movie)

        case queryChanged(String)

        case error(Error, RequestID.Type?)

        case loadPage(Int)
        case appendPage([Movie], Int)
    }

    struct LoadDataID: RequestID {}

    var body: some ReducerProtocol<State, Action> {
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

            case .error(let error, let type):
                state.transaction(.error(error))

                switch type {
                case is LoadDataID.Type:
                    state.isLoading = false
                default:
                    break
                }

            case .appendPage(let movies, let page):
                state.isLoading = false
                state.page = page
                state.canLoadMorePages = movies.count == 20
                state._items.append(contentsOf: movies)
                
            case .loadPage(let page):
                state.isLoading = true

                return .task {
                    do {
                        let items = try await getUpcomingMoviesUseCase(at: page)
                        return .appendPage(items.map { .init($0) }, page)
                    } catch {
                        return .error(error, LoadDataID.self)
                    }
                }.cancellable(id: LoadDataID.self, cancelInFlight: true)
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
