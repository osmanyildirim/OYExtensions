//
//  UITextField+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UITextField: OYInit {
    public typealias ViewType = UITextField

    /// Initializer method with `text` value
    public static func oy_init(text: String) -> UITextField {
        let textField: UITextField = oy_init()
        textField.text = text
        return textField
    }

    /// Get and Set left padding for UITextField
    public var oy_leftPadding: CGFloat? {
        get { leftView?.frame.oy_width }
        set(value) {
            self.leftView = .oy_init(x: 0, y: 0, width: value ?? 0, height: frame.oy_height)
            self.leftViewMode = .always
        }
    }

    /// Get and Set right padding for UITextField
    public var oy_rightPadding: CGFloat? {
        get { rightView?.frame.oy_width }
        set(value) {
            self.rightView = .oy_init(x: 0, y: 0, width: value ?? 0, height: frame.oy_height)
            self.rightViewMode = .always
        }
    }

    /// Get and Set monospaced for UITextField
    public var oy_monospaced: CGFloat? {
        get { defaultTextAttributes.oy_valueWith(key: .kern) as? CGFloat }
        set(value) { defaultTextAttributes.oy_set(key: .kern, value: value ?? 0) }
    }

    /// Set placeholder and text color for UITextField
    public func oy_set(placeholder: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    /// Add left icon and left padding
    public func oy_add(leftIcon: UIImage, padding: CGFloat) {
        let imageView = UIImageView.oy_init(image: leftIcon)
        imageView.contentMode = .center
        leftView = imageView
        leftView?.frame.size = .oy_init(leftIcon.size.oy_width + padding, leftIcon.size.oy_height)
        leftViewMode = .always
    }

    /// Clear text and attributed text
    public func oy_clear() {
        text?.removeAll()
        attributedText = NSAttributedString(string: "")
    }
    
    /// Set tint color of clear button
    public func oy_setClearButton(tintColor: UIColor) {
        let clearButton = value(forKey: "clearButton") as? UIButton
        let image = clearButton?.imageView?.image?.withRenderingMode(.alwaysTemplate)
        clearButton?.setImage(image, for: .normal)
        clearButton?.tintColor = tintColor
    }

    /// Set image of clear button
    func oy_setClearButton(image: UIImage?) {
        if let image, let clearButton = value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(image, for: .normal)
            clearButton.setImage(image, for: .highlighted)
        }
    }

    /// Returns replaced string of UITextField with entered text
    /// Should be used within the `textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)` method
    /// `let text = textField.shouldText(with: range, replacementString: string)`
    func oy_shouldText(with range: NSRange, replacementString string: String) -> String {
        guard let text = text else { return "" }
        return NSString(string: text).replacingCharacters(in: range, with: string)
    }

    /// Add done button to UITextField toolbar
    public func oy_addDoneButton(position: DoneButtonPosition = .right, title: String, style: UIBarStyle = .default, backgroundColor: UIColor? = nil, textColor: UIColor? = nil) {
        let keyboardToolbar = UIToolbar()

        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(resignFirstResponder))
        doneButton.tintColor = textColor
        keyboardToolbar.items = [doneButton]

        if position == .right {
            keyboardToolbar.items?.insert(leftSpace, at: 0)
        }

        if style == .default {
            keyboardToolbar.backgroundColor = backgroundColor
        }
        keyboardToolbar.barStyle = style
        keyboardToolbar.sizeToFit()
        inputAccessoryView = keyboardToolbar
    }

    /// Done button position
    public enum DoneButtonPosition {
        case left
        case right
    }
}
