//
//  UIPasteboard+Extension.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIPasteboard {
    /// `UIPasteboard.oy_copy("copiable text")`
    public static func oy_copy(_ text: String) {
        UIPasteboard.general.string = text
    }

    /// `UIPasteboard.oy_value` → output → "copiable text"
    public static var oy_value: String {
        guard let pasteboard = UIPasteboard.general.string else { return "" }
        return pasteboard
    }
}
