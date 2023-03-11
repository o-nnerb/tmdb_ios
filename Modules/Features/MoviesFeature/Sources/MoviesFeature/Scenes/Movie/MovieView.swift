//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI
import ComposableArchitecture

@MainActor
struct MovieView: View {

    let viewStore: ViewStoreOf<MovieReducer>

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LazyImage(
                    image: viewStore.backdrop,
                    label: Text("Backdrop image"),
                    isLoading: viewStore.isBackdropLoading
                )
                .scaledToFill()
                .frame(height: 200)
                .clipped()

                VStack(spacing: 16) {
                    HStack(spacing: 8) {
                        LazyImage(
                            image: viewStore.poster,
                            label: Text("Poster image"),
                            isLoading: viewStore.isPosterLoading
                        )
                        .scaledToFill()
                        .frame(width: 88, height: 128)
                        .clipped()

                        HStack(spacing: .zero) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewStore.movie.name)

                                if let genre = viewStore.movie.genre {
                                    Text(genre)
                                }

                                HStack(spacing: 4) {
                                    Image(systemName: "hand.thumbsup")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)

                                    Text("\(Int(viewStore.movie.votesAverage))%")

                                    Text("(\(viewStore.movie.votesCount))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Text("Release date: \(releaseDateFormatted)")
                            }

                            Spacer(minLength: .zero)
                        }
                    }

                    if let overview = viewStore.movie.overview {
                        HStack(spacing: .zero) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Overview")
                                    .font(.title3)
                                Text(overview)
                                    .foregroundColor(.secondary)
                            }

                            Spacer(minLength: .zero)
                        }
                    }

                    if let companies = viewStore.movie.companies {
                        HStack(spacing: .zero) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Production Companies")
                                    .font(.title3)
                                Text(companies)
                                    .foregroundColor(.secondary)
                            }

                            Spacer(minLength: .zero)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(Text(viewStore.movie.name))
        .toolbar {
            toolbarItems
        }
        .onAppear {
            viewStore.send(.loadPoster)
            viewStore.send(.loadBackdrop)
            viewStore.send(.loadDetail)
        }
    }
}

extension MovieView {

    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton {
                viewStore.send(.back)
            }
        }

        if viewStore.isMovieLoading {
            ToolbarItem(placement: .navigationBarTrailing) {
                ProgressView()
            }
        }
    }
}

extension MovieView {

    var releaseDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter.string(from: viewStore.movie.releaseDate) 
    }
}
