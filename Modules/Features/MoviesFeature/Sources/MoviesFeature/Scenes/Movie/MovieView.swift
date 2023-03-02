//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI

@MainActor
struct MovieView<ViewModel: MovieViewModelling>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LazyImage(
                    image: viewModel.backdrop,
                    label: Text("Backdrop image"),
                    isLoading: viewModel.isBackdropLoading
                )
                .scaledToFill()
                .frame(height: 200)
                .clipped()

                VStack(spacing: 16) {
                    HStack(spacing: 8) {
                        LazyImage(
                            image: viewModel.poster,
                            label: Text("Poster image"),
                            isLoading: viewModel.isPosterLoading
                        )
                        .scaledToFill()
                        .frame(width: 88, height: 128)
                        .clipped()

                        HStack(spacing: .zero) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.movie.name)

                                if let genre = viewModel.movie.genre {
                                    Text(genre)
                                }

                                HStack(spacing: 4) {
                                    Image(systemName: "hand.thumbsup")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)

                                    Text("\(Int(viewModel.movie.votesAverage))%")

                                    Text("(\(viewModel.movie.votesCount))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Text("Release date: \(releaseDateFormatted)")
                            }

                            Spacer(minLength: .zero)
                        }
                    }

                    if let overview = viewModel.movie.overview {
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

                    if let companies = viewModel.movie.companies {
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
        .navigationTitle(Text(viewModel.movie.name))
        .toolbar {
            toolbarItems
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

extension MovieView {

    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton {
                viewModel.back()
            }
        }

        if viewModel.isMovieLoading {
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
        return dateFormatter.string(from: viewModel.movie.releaseDate) 
    }
}
