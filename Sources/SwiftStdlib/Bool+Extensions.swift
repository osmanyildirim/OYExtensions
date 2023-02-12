//
//  Bool+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Bool {
    /// let value: Bool = true
    /// `value.oy_int` → output → (Int) 1
    public var oy_int: Int {
        self ? 1 : 0
    }

    /// let value: Bool = true
    /// `value.oy_string` → output → (String) "true"
    public var oy_string: String {
        description
    }
}
