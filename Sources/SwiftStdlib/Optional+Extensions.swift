//
//  Optional+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Optional {
    /// let value: String? = nil
    /// `value.oy_unwrap(or: "hello")` → output → "hello"
    public func oy_unwrap(or default: Wrapped) -> Wrapped {
        self ?? `default`
    }
}
