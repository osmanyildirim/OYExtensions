//
//  CGFloat+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension CGFloat {
    /// let value: CGFloat = 3.14
    /// `value.oy_cleanDecimal` → output → (String) "3"
    public var oy_cleanDecimal: String {
        String(format: "%.0f", self)
    }

    /// let value: CGFloat = 3.14
    /// `value.oy_int` → output → (Int) 3
    public var oy_int: Int {
        Int(self)
    }

    /// let value: CGFloat = 3.14
    /// `value.oy_string`→ output → (String) "3.14"
    public var oy_string: String {
        String(describing: self)
    }
    
    /// let value: CGFloat = 3.14
    /// `value.oy_string_1f` → output → (String) "3.1"
    public var oy_string_1f: String {
        String(format: "%.1f", self)
    }

    /// let value: CGFloat = 3.14
    /// `value.oy_string_2f` → output → (String) "3.14"
    public var oy_string_2f: String {
        String(format: "%.2f", self)
    }

    /// let value: CGFloat = 3.14
    /// `value.oy_float` → output → (Float) 3.1400001
    public var oy_float: Float {
        Float(self)
    }

    /// let value: CGFloat = 3.14
    /// `value.oy_double` → output → (Double) 3.1400000000000001
    public var oy_double: Double {
        Double(self)
    }

    /// `CGFloat.oy_random` → output → (CGFloat) 0.5
    public static var oy_random: Self {
        CGFloat.random(in: 0...1)
    }
}
