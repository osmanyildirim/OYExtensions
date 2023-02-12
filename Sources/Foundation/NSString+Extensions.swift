//
//  NSString+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension NSString {
    /// let value = NSString(string: "sample")
    /// `value.oy_string` → output → (String) "sample"
    public var oy_string: String {
        self as String
    }
}
