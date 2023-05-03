//
//  UIAlertController+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIAlertController {
    public typealias OYAlertSelectedClosure = ((_ selectedIndex: Int?, _ textFields: [UITextField]?) -> Void)
    public typealias OYActionSheetSelectedClosure = ((_ selectedIndex: Int?) -> Void)
    public typealias OYActionHandler = ((UIAlertAction) -> Void)

    /// Present UIAlertController and closure returns `selected button's index and textfields`
    public static func oy_showAlert(title: String?,
                                    message: String?,
                                    actions: [OYAction],
                                    textField: [OYAlertTextField]? = nil,
                                    viewController: UIViewController? = UIApplication.oy_topViewController,
                                    closure: OYAlertSelectedClosure?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for item in actions {
            alertController.addAction(title: item.title, style: item.style) { _ in
                closure?(actions.oy_indexOf(item: item), alertController.textFields)
            }
        }

        textField?.forEach({ item in
            alertController.addTextField { textField in
                textField.text = item.text
                textField.placeholder = item.placeholder
                textField.keyboardType = item.keyboardType
            }
        })
        
        viewController?.present(alertController, animated: true, completion: nil)
    }

    /// Present ActionSheet AlertController and closure returns `selected button's index`
    public static func oy_showActionSheet(title: String?,
                                          message: String?,
                                          actions: [OYAction],
                                          viewController: UIViewController? = UIApplication.oy_topViewController,
                                          closures: OYActionSheetSelectedClosure?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

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
