//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import SwiftUI
import NavigationKit
import ComposableArchitecture
import Factory
import SuperKit
import MoviesDomain
import MoviesScenes

@Reducer
struct MovieReducer: Reducer {

    @Injected(\.getMovieUseCase) var getMovieUseCase
    @Injected(\.getPhotoUseCase) var getPhotoUseCase

    @ObservableState
    struct State: Hashable {
        var movie: MovieDetail
        var poster: CGImage?
        var backdrop: CGImage?

        var isMovieLoading: Bool = false
        var isPosterLoading: Bool = false
        var isBackdropLoading: Bool = false

        let transaction = SceneTransaction<MovieDestination>()
    }

    @ObservableState
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
        case error(Error, CancelID?)
    }

    enum CancelID {
        case movie
        case poster
        case backdrop
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadDetail:
                state.isMovieLoading = true

                return .run { [movie = state.movie, getMovieUseCase] send in
                    await send(Self.loadDetail(movie, useCase: getMovieUseCase))
                }.cancellable(id: CancelID.movie, cancelInFlight: true)

            case .loadPoster:
                guard
                    state.poster == nil,
                    let posterPath = state.movie.posterPath,
                    !state.isPosterLoading
                else { return  .none }

                state.isPosterLoading = true

                return .run { [getPhotoUseCase] send in
                    await send(Self.loadPoster(posterPath, useCase: getPhotoUseCase))
                }.cancellable(id: CancelID.poster, cancelInFlight: true)

            case .loadBackdrop:
                guard
                    state.poster == nil,
                    let backdropPath = state.movie.backdropPath,
                    !state.isBackdropLoading
                else { return  .none }

                state.isBackdropLoading = true

                return .run { [getPhotoUseCase] send in
                    await send(Self.loadBackdrop(backdropPath, useCase: getPhotoUseCase))
                }.cancellable(id: CancelID.backdrop, cancelInFlight: true)

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
                state.transaction(.error(error))

                switch id {
                case .movie:
                    state.isMovieLoading = false
                case .poster:
                    state.isPosterLoading = false
                case .backdrop:
                    state.isBackdropLoading = false
                case .none:
                    break
                }

            case .back:
                state.transaction(.back)
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

    static func loadDetail(_ movie: MovieDetail, useCase: GetMovieUseCaseProtocol) async -> MovieReducer.Action {
        do {
            let movie = try await useCase(movie.id)
            return .movie(.init(movie))
        } catch {
            return .error(error, .movie)
        }
    }

    static func loadPoster(_ posterPath: String, useCase: GetPhotoUseCaseProtocol) async -> MovieReducer.Action {
        do {
            let data = try await useCase(posterPath)
            return .poster(getImage(from: data))
        } catch {
            return .poster(nil)
        }
    }

    static func loadBackdrop(_ backdropPath: String, useCase: GetPhotoUseCaseProtocol) async -> MovieReducer.Action {
        do {
            let data = try await useCase(backdropPath)
            return .backdrop(getImage(from: data))
        } catch {
            return .backdrop(nil)
        }
    }
}

extension MovieReducer {

    static func getImage(from data: Data) -> CGImage? {
        guard let ciImage = CIImage(data: data) else {
            return nil
        }
        let context = CIContext()
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}

protocol RequestID {}
