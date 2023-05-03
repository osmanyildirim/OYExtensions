//
//  AttributedString+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension NSAttributedString {
    /// `let attrString = NSAttributedString.oy_init("text", [.foregroundColor: UIColor.red])`
    public static func oy_init(_ text: String, _ attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        NSAttributedString(string: text, attributes: attributes)
    }

    /// `attrString.oy_attribute([.backgroundColor: UIColor.yellow, .underlineStyle: true])`
    public func oy_attribute(_ attributes: [Key: Any]) -> NSAttributedString {
        guard !string.isEmpty else { return self }

        let copy = NSMutableAttributedString(attributedString: self)
        copy.addAttributes(attributes, range: NSRange(0..<length))
        return copy
    }

    /// `attrString.oy_color(.black)`
    public func oy_color(_ color: UIColor) -> NSAttributedString {
        oy_attribute([.foregroundColor: color])
    }

    /// `attrString.oy_backgroundColor(.blue)`
    public func oy_backgroundColor(_ color: UIColor) -> NSAttributedString {
        oy_attribute([.backgroundColor: color])
    }

    /// `attrString.oy_font(.systemFont(ofSize: 12))`
    public func oy_font(_ font: UIFont) -> NSAttributedString {
        oy_attribute([.font: font])
    }

    /// `attrString.oy_underline(true)`
    public func oy_underline(_ value: Bool) -> NSAttributedString {
        oy_attribute([.underlineStyle: value])
    }
}

extension NSMutableAttributedString {
    /// Apply font attribute
    func oy_applyFont(_ font: UIFont) {
        let base = font.fontDescriptor
        let range = NSRange(location: 0, length: length)
        beginEditing()
        enumerateAttribute(.font, in: range, options: []) { object, range, _ in
            guard let font = object as? UIFont else { return }
            let traits = font.fontDescriptor.symbolicTraits
            guard let descriptor = base.withSymbolicTraits(traits) else { return }
            let fontValue = UIFont(descriptor: descriptor, size: descriptor.pointSize)
            removeAttribute(.font, range: range)
            addAttribute(.font, value: fontValue, range: range)
        }
        endEditing()
    }
}
