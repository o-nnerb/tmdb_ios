//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SwiftUI
import Injection
import MoviesDomain

extension MovieItemView {

    @MainActor
    class ViewModel: ObservableObject {

        @Injected var getPhotoUseCase: GetPhotoUseCaseProtocol
        @Injected var getGenreUseCase: GetGenreUseCaseProtocol

        @Published var genre: String?
        @Published var poster: CGImage?
        @Published var isPosterLoading: Bool = false

        private var currentMovie: Movie?

        func intercept(_ movie: Movie) -> Movie {
            guard currentMovie?.id != movie.id else {
                return movie
            }

            currentMovie = movie
            Task {
                isPosterLoading = true
                if let path = movie.posterPath, let data = try? await ImageManager.shared.getPhoto(path) {
                    poster = getImage(from: data)
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

    func getImage(from data: Data) -> CGImage? {
        guard let ciImage = CIImage(data: data) else {
            return nil
        }
        let context = CIContext()
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}
