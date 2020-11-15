//
//  UpcomingMovieViewCell.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import UIKit
import SDWebImage

class UpcomingMovieViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explicityView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var indicatorView: UIImageView!

    weak var dimmedView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        explicityView.layer.cornerRadius = 3
        explicityView.layer.borderWidth = 2
        explicityView.layer.borderColor = UIColor.systemRed.cgColor

        selectionStyle = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        OperationQueue.main.addOperation {
            super.setSelected(false, animated: true)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        explicityView.layer.borderColor = UIColor.systemRed.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.separatorInset = .init(
            top: .zero,
            left: movieImageView.frame.width + 30,
            bottom: .zero,
            right: .zero
        )
    }

    func configure(_ movie: Movie) {
        explicityView.superview?.isHidden = !movie.isAdult
        titleLabel.text = movie.title
        popularityLabel.text = "\(Int(movie.votes.average * 10))%"

        votesCountLabel.text = "(\(movie.votes.count))"
        votesCountLabel.alpha = movie.votes.count == .zero ? .zero : 1

        releaseLabel.text = movie.releaseDate.string("dd/mm/YYYY")

        genreLabel.text = GenresService.shared
            .genres
            .first?
            .name

        if let posterPath = movie.posterPath {
            movieImageView.sd_setImage(with: URL(string: "\(TMDbAPI.imagesPath)\(posterPath)"))
        } else {
            movieImageView.image = nil
        }
    }
}
