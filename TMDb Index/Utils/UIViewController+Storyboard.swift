//
//  File.swift
//  TMDb Index
//
//  Created by brennobemoura on 15/11/20.
//

import UIKit

extension UIViewController {
    static func storyboard(named: String = "Main", identifier: String? = nil, bundle: Bundle? = nil) -> Self {
        UIStoryboard(
            name: named,
            bundle: bundle
        )
        .instantiateViewController(
            withIdentifier: identifier ?? "\(Self.self)Identifier"
        ) as! Self
    }
}
