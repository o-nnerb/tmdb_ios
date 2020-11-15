//
//  Alert.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import Foundation
import UIKit

struct Alert {
    weak var viewController: UIViewController!
    fileprivate var title: String?
    fileprivate var message: String?
    fileprivate var buttons: [(UIAlertAction.Style, String, () -> Void)] = []

    init(_ viewController: UIViewController!) {
        self.viewController = viewController
    }

    fileprivate func edit(_ edit: (inout Self) -> Void) -> Self {
        var mutableSelf = self
        edit(&mutableSelf)
        return mutableSelf
    }

    func present() {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if buttons.isEmpty {
            alertController.addAction(.init(title: "Cancelar", style: .cancel, handler: nil))
        } else {
            buttons.forEach { style, title, tapHandler in
                alertController.addAction(.init(title: title, style: style, handler: { _ in tapHandler() }))
            }
        }

        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension Alert {
    func title(_ string: String?) -> Self {
        edit {
            $0.title = string
        }
    }

    func message(_ string: String?) -> Self {
        edit {
            $0.message = string
        }
    }

    func cancelButton(_ title: String, onTap: @escaping () -> Void) -> Self {
        edit {
            $0.buttons = [(.cancel, title, onTap)] + $0.buttons.filter { $0.0 == .cancel }
        }
    }

    func defaultButton(_ title: String, onTap: @escaping () -> Void) -> Self {
        edit {
            $0.buttons = $0.buttons.filter { $0.0 != .destructive }
                + [(.default, title, onTap)]
                + $0.buttons.filter { $0.0 == .destructive }
        }
    }

    func destructiveButton(_ title: String, onTap: @escaping () -> Void) -> Self {
        edit {
            $0.buttons = $0.buttons.filter { $0.0 == .destructive } + [(.destructive, title, onTap)]
        }
    }
}
