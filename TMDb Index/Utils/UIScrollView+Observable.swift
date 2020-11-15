//
//  UIScrollView+Observable.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {

    func reachedBottom(_ offset: CGFloat = 0) -> Observable<Void> {
        self.contentOffset.map { [weak base] in
            $0.y >= ((base?.contentSize.height ?? .zero) - (base?.frame.size.height ?? .zero) - offset)
        }
        .distinctUntilChanged()
        .filter { $0 }
        .map { _ in () }
    }
}
