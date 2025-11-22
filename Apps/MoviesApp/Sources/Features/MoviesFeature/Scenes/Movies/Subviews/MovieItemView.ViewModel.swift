//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SwiftUI
import Factory
import MoviesDomain

extension MovieItemView {

    @Observable @MainActor
    final class ViewModel {

        @ObservationIgnored
        @Injected(\.getPhotoUseCase) var getPhotoUseCase

        @ObservationIgnored
        @Injected(\.getGenreUseCase) var getGenreUseCase

        var genre: String?
        var poster: CGImage?
        var isPosterLoading: Bool = false

        private var currentMovie: Movie?

        func intercept(_ movie: Movie) -> Movie {
            guard currentMovie?.id != movie.id else {
                return movie
            }

            currentMovie = movie
            Task {
                isPosterLoading = true
                if let path = movie.posterPath, let data = try? await getPhotoUseCase(path) {
                    poster = await getImage(from: data)
                } else {
                    poster = nil
                }
                isPosterLoading = false
            }

            if let genreID = movie.genreID {
                Task {
                    genre = try? await getGenreUseCase(genreID).name
                }
            }
            return movie
        }
    }
}

extension MovieItemView.ViewModel {

    @concurrent
    func getImage(from data: Data) async -> CGImage? {
        guard let ciImage = CIImage(data: data) else {
            return nil
        }
        let context = CIContext()
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}
