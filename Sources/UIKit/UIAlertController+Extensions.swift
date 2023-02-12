//
//  UIAlertController+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIAlertController {
    public typealias OYSelectedClosure = ((_ selectedIndex: Int?) -> Void)
    public typealias OYActionHandler = ((UIAlertAction) -> Void)

    /// Present UIAlertController and closure returns `selected button's index`
    public static func oy_showActionSheet(title: String?,
                                          message: String?,
                                          actions: [OYAction],
                                          preferredStyle: Style = .actionSheet,
                                          viewController: UIViewController? = UIApplication.oy_topViewController,
                                          closures: OYSelectedClosure?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for item in actions {
            alertController.addAction(title: item.title, style: item.style) { _ in
                closures?(actions.oy_indexOf(item: item))
            }
        }
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

extension UIAlertController {
    /// Add action for UIAlertController
    private func addAction(title: String?, style: UIAlertAction.Style?, handler: OYActionHandler? = nil) {
        let action = UIAlertAction(title: title, style: style ?? .default, handler: handler)
        addAction(action)
    }
}

public struct OYAction: Equatable {
    var title: String
    var style: UIAlertAction.Style
}
