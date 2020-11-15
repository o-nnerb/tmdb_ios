//
//  GenresService.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import RxSwift
import RxCocoa

struct GenresService {
    static let shared =  GenresService()

    private let genresRelay: BehaviorRelay<[Movie.Genre]> = .init(value: getGenres())
    private let disposeBag = DisposeBag()

    func load() {
        TMDbAPI.shared.request(.genres)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([Movie.Genre].self, atKeyPath: "genres")
            .subscribe(onSuccess: {
                Self.setGenres($0)
                self.genresRelay.accept($0)
            }).disposed(by: disposeBag)
    }

    var genres: [Movie.Genre] {
        genresRelay.value
    }

    func asObservable() -> Observable<[Movie.Genre]> {
        genresRelay.asObservable()
    }
}

private extension GenresService {
    static func getGenres() -> [Movie.Genre] {
        guard let data = UserDefaults.standard.data(forKey: "genres") else {
            return []
        }

        return (try? JSONDecoder().decode([Movie.Genre].self, from: data)) ?? []
    }

    static func setGenres(_ newValue: [Movie.Genre]) {
        guard let data = try? JSONEncoder().encode(newValue) else {
            return
        }

        UserDefaults.standard.setValue(data, forKey: "genres")
    }
}
