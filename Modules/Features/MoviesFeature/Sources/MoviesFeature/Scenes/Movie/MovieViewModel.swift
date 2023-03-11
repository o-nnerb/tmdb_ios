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
import ComposableArchitecture

struct MovieReducer: ReducerProtocol {

    @Injected var getMovieUseCase: GetMovieUseCaseProtocol
    @Injected var getPhotoUseCase: GetPhotoUseCaseProtocol

    struct State: Hashable {
        var movie: MovieDetail
        var poster: CGImage?
        var backdrop: CGImage?
        var destination: MovieDestination?

        var isMovieLoading: Bool = false
        var isPosterLoading: Bool = false
        var isBackdropLoading: Bool = false
    }

    enum Action {
        // MARK: - Load data
        case loadDetail
        case loadPoster
        case loadBackdrop

        // MARK: - Post changes
        case movie(MovieDetail)
        case poster(CGImage?)
        case backdrop(CGImage?)

        // MARK: - Destination
        case back
        case error(Error, RequestID.Type?)
    }

    private enum MovieID: RequestID {}
    private enum PosterID: RequestID {}
    private enum BackdropID: RequestID {}

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadDetail:
                state.isMovieLoading = true

                return .task { [movie = state.movie] in
                    await loadDetail(movie)
                }.cancellable(id: MovieID.self, cancelInFlight: true)

            case .loadPoster:
                guard
                    state.poster == nil,
                    let posterPath = state.movie.posterPath,
                    !state.isPosterLoading
                else { return  .none }

                state.isPosterLoading = true

                return .task {
                    await loadPoster(posterPath)
                }.cancellable(id: PosterID.self, cancelInFlight: true)

            case .loadBackdrop:
                guard
                    state.poster == nil,
                    let backdropPath = state.movie.backdropPath,
                    !state.isBackdropLoading
                else { return  .none }

                state.isBackdropLoading = true

                return .task {
                    await loadBackdrop(backdropPath)
                }.cancellable(id: BackdropID.self, cancelInFlight: true)

            case .movie(let movie):
                state.movie = movie
                state.isMovieLoading = false

                return .concatenate(
                    .send(.loadPoster),
                    .send(.loadBackdrop)
                )

            case .poster(let poster):
                state.poster = poster
                state.isPosterLoading = false

            case .backdrop(let backdrop):
                state.backdrop = backdrop
                state.isBackdropLoading = false

            case .error(let error, let id):
                state.destination = .error(error)

                switch id {
                case is MovieID.Type:
                    state.isMovieLoading = false
                case is PosterID.Type:
                    state.isPosterLoading = false
                case is BackdropID.Type:
                    state.isBackdropLoading = false
                default:
                    break
                }

            case .back:
                state.destination = .back
            }

            return .none
        }
    }
}

extension MovieReducer.State {

    init(_ scene: MovieScene) {
        self.movie = .init(scene.movie)
    }
}

extension MovieReducer {

    func loadDetail(_ movie: MovieDetail) async -> MovieReducer.Action {
        do {
            let movie = try await getMovieUseCase(movie.id)
            return .movie(.init(movie))
        } catch {
            return .error(error, MovieID.self)
        }
    }

    func loadPoster(_ posterPath: String) async -> MovieReducer.Action {
        do {
            let data = try await getPhotoUseCase(posterPath)
            return .poster(getImage(from: data))
        } catch {
            return .poster(nil)
        }
    }

    func loadBackdrop(_ backdropPath: String) async -> MovieReducer.Action {
        do {
            let data = try await getPhotoUseCase(backdropPath)
            return .backdrop(getImage(from: data))
        } catch {
            return .backdrop(nil)
        }
    }
}

extension MovieReducer {

    func getImage(from data: Data) -> CGImage? {
        guard let ciImage = CIImage(data: data) else {
            return nil
        }
        let context = CIContext()
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}

protocol RequestID {}
