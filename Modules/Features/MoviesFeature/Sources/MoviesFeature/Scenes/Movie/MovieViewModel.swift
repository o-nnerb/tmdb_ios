//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI
import CoreApp
import CoreKit
import Injection
import CoreScene

class MovieViewModel: ViewModel<MovieDestination> {

    @Injected var getMovieUseCase: GetMovieUseCaseProtocol
    @Injected var getPhotoUseCase: GetPhotoUseCaseProtocol

    @Published var movie: MovieDetail
    @Published var poster: CGImage?
    @Published var backdrop: CGImage?

    @Published var isMovieLoading: Bool = false
    @Published var isPosterLoading: Bool = false
    @Published var isBackdropLoading: Bool = false

    init(_ scene: MovieScene) {
        self.movie = .init(scene.movie)
        super.init()
    }
}

extension MovieViewModel: MovieViewModelling {

    func back() {
        destination = .back
    }

    func loadData() {
        loadPoster()
        loadBackdrop()

        Task {
            isMovieLoading = true

            do {
                let movie = try await getMovieUseCase(movie.id)
                self.movie = .init(movie)
                loadPoster()
                loadBackdrop()
            } catch {
                destination = .error(error)
            }

            isMovieLoading = false
        }
    }
}

extension MovieViewModel {
    
    func loadPoster() {
        guard
            poster == nil,
            let posterPath = movie.posterPath,
            !isPosterLoading
        else { return }

        Task {
            isPosterLoading = true

            do {
                let data = try await getPhotoUseCase(posterPath)
                poster = getImage(from: data)
            } catch {
                poster = nil
            }

            isPosterLoading = false
        }
    }
    
    func loadBackdrop() {
        guard
            backdrop == nil,
            let backdropPath = movie.backdropPath,
            !isBackdropLoading
        else { return }

        Task {
            isBackdropLoading = true

            do {
                let data = try await getPhotoUseCase(backdropPath)
                backdrop = getImage(from: data)
            } catch {
                backdrop = nil
            }

            isBackdropLoading = false
        }
    }
}

extension MovieViewModel {

    func getImage(from data: Data) -> CGImage? {
        guard let ciImage = CIImage(data: data) else {
            return nil
        }
        let context = CIContext()
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}
