//
//  UITextView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UITextView {
    typealias ViewType = UITextView

    /// Initializer method with `text, isEditable and isSelectable` values
    public static func oy_init(text: String, isEditable: Bool = false, isSelectable: Bool = false) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.isEditable = isEditable
        textView.isSelectable = isSelectable
        return textView
    }

    /// Center the UITextView vertically
    public func oy_centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let topOffset = (bounds.size.height - sizeThatFits(fittingSize).height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

    /// Clear UITextView's text and attributed text
    public func oy_clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// Scroll to the most content offset by position
    public func oy_scrollTo(position: Position) {
        var range = NSRange()

        if position == .top {
            range = position == .top ? NSRange(location: text.count - 1, length: 1) : NSRange(location: 0, length: 1)
        }
        scrollRangeToVisible(range)
    }

    /// Wrap UITextView's content
    public func oy_wrapToContent() {
        contentInset = UIEdgeInsets.zero
        scrollIndicatorInsets = UIEdgeInsets.zero
        contentOffset = CGPoint.zero
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }

    /// Add right padding for UITextView
    public func oy_rightPadding(_ level: CGFloat) {
        self.textContainerInset = UIEdgeInsets.init(top: self.textContainerInset.top, left: self.textContainerInset.left, bottom: self.textContainerInset.bottom, right: level)
    }

    /// Add done button to UITextView toolbar
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
}
extension UITextView {
    /// Scroll position
    public enum Position {
        case top
        case bottom
    }

    /// Done button position
    public enum DoneButtonPosition {
        case left
        case right
    }
}
