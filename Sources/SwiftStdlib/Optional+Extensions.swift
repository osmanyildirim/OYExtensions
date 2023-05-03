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
    public func oy_unwrap(default: Wrapped) -> Wrapped {
        self ?? `default`
    }

    /// let value: Int? = 18
    /// `value.oy_unwrap { unwrapped in
    ///     print(unwrapped) → output → 18
    /// `}
    public func oy_unwrap<T>(_ transform: ((_ unwrapped: Wrapped) -> T)) -> T? {
        guard let value = self else { return nil }
        return transform(value)
    }
}
