//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI
import ComposableArchitecture

@MainActor
struct MoviesView: View {

    let viewStore: ViewStoreOf<MoviesReducer>

    var body: some View {
        Group {
            switch displayMode {
            case .empty:
                MoviesEmptyView(
                    title: "No Movies Available",
                    description: "There's no movie available at TMDb API to display"
                )
            case .notFound:
                MoviesEmptyView(
                    title: "Movie Not Found",
                    description: "The current search query typed couldn't find any results"
                )
            case .items:
                List {
                    if !viewStore.items.isEmpty {
                        Section {
                            ForEach(viewStore.items) { item in
                                MovieItemView(item) {
                                    viewStore.send(.submit(item))
                                }
                                .onAppear {
                                    viewStore.send(.loadNextPageIfNeeded(item))
                                }
                            }
                        } header: {
                            if !viewStore.query.isEmpty {
                                Text("Results")
                            }
                        }
                    }

                    if viewStore.isLoading {
                        Section {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(Text("Upcoming Movies"))
        .searchable(text: viewStore.binding(get: \.query) {
            .queryChanged($0)
        })
        .onAppear {
            viewStore.send(.loadData)
        }
    }
}

extension MoviesView {

    enum DisplayMode {
        case empty
        case notFound
        case items
    }

    var displayMode: DisplayMode {
        guard
            !viewStore.isLoading,
            viewStore.items.isEmpty
        else { return .items }

        if !viewStore.query.isEmpty {
            return .notFound
        } else {
            return .empty
        }
    }
}
