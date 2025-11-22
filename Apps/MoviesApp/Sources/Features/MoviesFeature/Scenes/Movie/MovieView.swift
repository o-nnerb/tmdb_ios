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

    let store: StoreOf<MovieReducer>

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LazyImage(
                    image: store.backdrop,
                    label: Text("Backdrop image"),
                    isLoading: store.isBackdropLoading
                )
                .scaledToFill()
                .frame(height: 200)
                .clipped()

                VStack(spacing: 16) {
                    HStack(spacing: 8) {
                        LazyImage(
                            image: store.poster,
                            label: Text("Poster image"),
                            isLoading: store.isPosterLoading
                        )
                        .scaledToFill()
                        .frame(width: 88, height: 128)
                        .clipped()

                        HStack(spacing: .zero) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(store.movie.name)

                                if let genre = store.movie.genre {
                                    Text(genre)
                                }

                                HStack(spacing: 4) {
                                    Image(systemName: "hand.thumbsup")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)

                                    Text("\(Int(store.movie.votesAverage))%")

                                    Text("(\(store.movie.votesCount))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Text("Release date: \(releaseDateFormatted)")
                            }

                            Spacer(minLength: .zero)
                        }
                    }

                    if let overview = store.movie.overview {
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

                    if let companies = store.movie.companies {
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
        .navigationTitle(Text(store.movie.name))
        .toolbar {
            toolbarItems
        }
        .onAppear {
            store.send(.loadPoster)
            store.send(.loadBackdrop)
            store.send(.loadDetail)
        }
    }
}

extension MovieView {

    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton {
                store.send(.back)
            }
        }

        if store.isMovieLoading {
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
        return dateFormatter.string(from: store.movie.releaseDate) 
    }
}
