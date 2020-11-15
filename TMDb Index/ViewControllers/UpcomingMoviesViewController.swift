//
//  MoviesViewController.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import UIKit
import RxSwift
import RxCocoa

class UpcomingMoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNav()
        prepareTable()

        viewModel = UpcomingMoviesViewModel()
    }

    func prepareNav() {
        navigationItem.title = "Upcoming Movies"

        if #available(iOS 11, *) {
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.prefersLargeTitles = true

            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.obscuresBackgroundDuringPresentation = false
            search.searchBar.placeholder = "Search"
            navigationItem.searchController = search
        }
    }

    func prepareTable() {
        tableView.register(UINib(nibName: "UpcomingMovieViewCell", bundle: nil), forCellReuseIdentifier: "UpcomingMovieViewCellIdentifier")
    }
}

extension UpcomingMoviesViewController: ViewModelBindable {
    func bindViewModel(_ viewModel: UpcomingMoviesViewModel) {

        viewModel.moviesRequest
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                if case .error(let error) = $0 {
                    Alert(self)
                        .error(error)
                        .present()
                    return
                }
            }).disposed(by: disposeBag)

        viewModel.filteredItems
            .bind(to: tableView.rx.items(cellIdentifier: "UpcomingMovieViewCellIdentifier", cellType: UpcomingMovieViewCell.self)) { _, item, cell in
                cell.configure(item)
            }.disposed(by: disposeBag)

        tableView.rx.reachedBottom(UIScreen.main.bounds.height / 2.0)
            .bind(to: viewModel.loadNexPage)
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController(
                    MovieViewController.configured($0),
                    animated: true
                )
            }).disposed(by: disposeBag)

        tableView.rx.isLoading(viewModel.activityRelay)
            .disposed(by: disposeBag)
    }
}

extension UpcomingMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchQueryRelay.accept(searchController.searchBar.text)
    }
}
