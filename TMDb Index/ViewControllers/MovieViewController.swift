//
//  MovieViewController.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MovieViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explicityView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var votesAverageLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!

    var movie: Movie!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNav()
        prepareViews()

        self.viewModel = MovieViewModel(movie)
    }

    func prepareNav() {
        navigationItem.title = movie.title
    }

    func prepareViews() {
        explicityView.layer.cornerRadius = 3
        explicityView.layer.borderWidth = 2
        explicityView.layer.borderColor = UIColor.systemRed.cgColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        explicityView.layer.borderColor = UIColor.systemRed.cgColor
    }

    func update(_ movie: Movie) {
        explicityView.superview?.isHidden = !movie.isAdult
        titleLabel.text = movie.title
        votesAverageLabel.text = "\(Int(movie.votes.average * 10))%"

        votesCountLabel.text = "(\(movie.votes.count))"
        votesCountLabel.alpha = movie.votes.count == .zero ? .zero : 1

        releaseDateLabel.text = movie.releaseDate.string("dd/mm/YYYY")

        genreLabel.text = GenresService.shared
            .genres
            .first?
            .name

        if let posterPath = movie.posterPath {
            coverImageView.sd_setImage(with: URL(string: "\(TMDbAPI.imagesPath)\(posterPath)"))
        } else {
            coverImageView.image = nil
        }

        if let backdropPath = movie.backdropPath {
            backdropImageView.sd_setImage(with: URL(string: "\(TMDbAPI.imagesPath)\(backdropPath)"))
        } else {
            backdropImageView.image = nil
        }

        overviewLabel.text = movie.overview
        companiesLabel.text = movie.productionCompanies.map { $0.name }.joined(separator: ", ")
    }
}

extension MovieViewController: ViewModelBindable {
    func bindViewModel(_ viewModel: MovieViewModel) {

        viewModel.movieRelay.subscribe(onNext: { [weak self] in
            self?.update($0)
        }).disposed(by: disposeBag)

        viewModel.movieRequest
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                if case .error(let error) = $0 {
                    Alert(self)
                        .error(error)
                        .present()
                    return
                }
            }).disposed(by: disposeBag)
    }
}

extension MovieViewController {
    static func configured(_ movie: Movie) -> MovieViewController {
        let movieViewController = MovieViewController.storyboard()
        movieViewController.movie = movie
        return movieViewController
    }
}
