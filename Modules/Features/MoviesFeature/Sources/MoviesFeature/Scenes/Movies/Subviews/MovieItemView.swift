//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SwiftUI

struct MovieItemView: View {

    @StateObject var viewModel = ViewModel()

    let movie: Movie
    let action: () -> Void

    init(_ movie: Movie, action: @escaping () -> Void) {
        self.movie = movie
        self.action = action
    }

    var body: some View {
        let movie = viewModel.intercept(movie)

        Button(action: action) {
            HStack(spacing: .zero) {
                HStack(spacing: 8) {
                    LazyImage(
                        image: viewModel.poster,
                        label: Text("Poster"),
                        isLoading: viewModel.isPosterLoading
                    )
                    .scaledToFill()
                    .frame(width: 88, height: 128)
                    .clipped()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.name)
                            .font(.title3)

                        HStack(spacing: 4) {
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)

                            Text("\(Int(movie.votesAverage))%")
                            Text("(\(movie.votesCount))")
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }

                        Text("Release date: \(releaseDateFormatted)")
                    }
                }
                .foregroundColor(.primary)

                Spacer(minLength: 16)

                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.init(.secondary))
            }
        }
    }
}

extension MovieItemView {

    var releaseDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter.string(from: movie.releaseDate)
    }
}
