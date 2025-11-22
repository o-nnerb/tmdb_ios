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

    let store: StoreOf<MoviesReducer>

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
                    if !store.items.isEmpty {
                        Section {
                            ForEach(store.items) { item in
                                MovieItemView(item) {
                                    store.send(.submit(item))
                                }
                                .onAppear {
                                    store.send(.loadNextPageIfNeeded(item))
                                }
                            }
                        } header: {
                            if !store.query.isEmpty {
                                Text("Results")
                            }
                        }
                    }

                    if store.isLoading {
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
        .searchable(text: .init(
            get: { store.query },
            set: { store.send(.queryChanged($0)) }
        ))
        .onAppear {
            store.send(.loadData)
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
            !store.isLoading,
            store.items.isEmpty
        else { return .items }

        if !store.query.isEmpty {
            return .notFound
        } else {
            return .empty
        }
    }
}
