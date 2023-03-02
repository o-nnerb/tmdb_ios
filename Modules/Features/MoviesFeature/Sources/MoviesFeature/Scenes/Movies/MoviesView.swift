//
//  File.swift
//  
//
//  Created by Brenno Giovanini de Moura on 15/02/23.
//

import SwiftUI

@MainActor
struct MoviesView<ViewModel: MoviesViewModelling>: View {

    @ObservedObject var viewModel: ViewModel

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
                    if !viewModel.items.isEmpty {
                        Section {
                            ForEach(viewModel.items) { item in
                                MovieItemView(item) {
                                    viewModel.submit(item)
                                }
                                .onAppear {
                                    viewModel.loadNextPageIfNeeded(item)
                                }
                            }
                        } header: {
                            if !viewModel.query.isEmpty {
                                Text("Results")
                            }
                        }
                    }

                    if viewModel.isLoading {
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
        .searchable(text: $viewModel.query)
        .onAppear {
            viewModel.loadData()
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
            !viewModel.isLoading,
            viewModel.items.isEmpty
        else { return .items }

        if !viewModel.query.isEmpty {
            return .notFound
        } else {
            return .empty
        }
    }
}
