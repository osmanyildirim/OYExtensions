//
//  UISearchBar+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UISearchBar: OYInit {
    public typealias ViewType = UISearchBar

    /// Get UISearchBar's optional UITextField
    public var oy_textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap(\.subviews)
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }

    /// Clear UISearchBar's text
    public func oy_clear() {
        text?.removeAll()
    }

    /// Set placeholder
    public func oy_set(placeHolder: String) {
        oy_textField?.placeholder = placeholder
    }

    /// Set tex color
    public func oy_set(textColor: UIColor) {
        oy_textField?.textColor = textColor
    }

    /// Set placeholder text color
    public func oy_set(placeholderTextColor: UIColor) {
        oy_textField?.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
            attributes: [.foregroundColor: placeholderTextColor])
    }

    /// Set placeholder textfield background color
    public func oy_set(textFieldColor: UIColor) {
        switch searchBarStyle {
        case .minimal:
            oy_textField?.layer.backgroundColor = textFieldColor.cgColor
            oy_textField?.layer.cornerRadius = 6
        case .prominent, .default:
            oy_textField?.backgroundColor = textFieldColor
        @unknown default: return
        }
    }

    /// Set search icon
    public var oy_searchIcon: UIImage? {
        get {
            let subViews = subviews.flatMap(\.subviews)
            return ((subViews.first { $0 is UIImageView }) as? UIImageView)?.image
        }
        set(value) { setImage(value, for: .search, state: .normal) }
    }
}
