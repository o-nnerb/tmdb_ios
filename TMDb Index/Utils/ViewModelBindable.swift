//
//  ViewModelBindable.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation

protocol ViewModelBindable: class {
    associatedtype ViewModel

    func bindViewModel(_ viewModel: ViewModel)
}

private var kViewModel = 0

extension ViewModelBindable {
    var viewModel: ViewModel! {
        get { objc_getAssociatedObject(self, &kViewModel) as? ViewModel }
        set {
            objc_setAssociatedObject(self, &kViewModel, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.bindViewModel(newValue)
        }
    }
}
