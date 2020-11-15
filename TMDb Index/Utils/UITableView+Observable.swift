//
//  UITableView+Observable.swift
//  TMDb Index
//
//  Created by brennobemoura on 15/11/20.
//

import Foundation
import RxSwift
import UIKit

extension Reactive where Base: UITableView {
    func isLoading<O>(_ isLoading: O) -> Disposable where O: ObservableConvertibleType, O.Element == Bool {
        isLoading
            .asObservable()
            .subscribeOn(MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak base] in
                guard $0 else {
                    base?.backgroundView = nil
                    return
                }
                
                let loadingView = base?.backgroundView as? UIActivityIndicatorView

                if loadingView != nil {
                    return
                }

                let activityView = UIActivityIndicatorView(style: .gray)
                base?.backgroundView = activityView
                activityView.transform = .init(scaleX: 1.5, y: 1.5)
                activityView.startAnimating()
            })
    }
}
