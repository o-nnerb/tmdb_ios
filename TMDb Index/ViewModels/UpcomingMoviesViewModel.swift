//
//  UpcomingMoviesViewModel.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import RxSwift
import RxCocoa

class UpcomingMoviesViewModel {

    let activityRelay = ActivityIndicator()
    let items: BehaviorRelay<[Movie]> = .init(value: [])
    let actualPage: BehaviorRelay<Int> = .init(value: .zero)
    let loadNexPage: PublishRelay<Void> = .init()

    let searchQueryRelay: BehaviorRelay<String?> = .init(value: nil)

    init() {
        
    }
}

extension UpcomingMoviesViewModel {
    var filteredItems: Observable<[Movie]> {
        items.flatMapLatest { [weak self] items -> Observable<[Movie]> in
            guard let self = self else {
                return .empty()
            }

            return self.searchQueryRelay.map {
                let query = $0 ?? ""

                return query.isEmpty ? items :
                    items.filter { $0.title.contains(query) }
            }
        }
    }
}

extension UpcomingMoviesViewModel {
    var moviesRequest: Observable<APIResult<APIArray<Movie>>> {
        loadNexPage
            .startWith(())
            .flatMapLatest { [weak self] _ -> Observable<APIResult<APIArray<Movie>>> in
                guard let self = self else {
                    return .empty()
                }

                return TMDbAPI.shared.request(.upcomingMovies(page: self.actualPage.value + 1))
                    .filterSuccessfulStatusAndRedirectCodes()
                    .apiMap(APIArray<Movie>.self)
                    .trackActivity(self.activityRelay)
                    .do(onNext: { [weak self] in
                        guard let self = self else {
                            return
                        }

                        if case .success(let wrapper) = $0 {
                            self.items.accept(self.items.value + wrapper.results)

                            guard wrapper.totalPages >= self.actualPage.value else {
                                return
                            }

                            self.actualPage.accept(wrapper.page)
                        }
                    })
            }
    }
}
