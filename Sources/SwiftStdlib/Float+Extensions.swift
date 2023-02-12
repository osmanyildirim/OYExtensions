//
//  Float+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Float {
    /// let value: Float = 3.14
    /// `value.oy_string` → output → (String) "3.14"
    public var oy_string: String {
        String(describing: self)
    }

    /// let value: Float = 3.14
    /// `value.oy_int` → output → (Int) 3
    public var oy_int: Int {
        Int(self)
    }

    /// let value: Float = 3.14
    /// `value.oy_double` → output → (Double) 3.1400001049041748
    public var oy_double: Double {
        Double(self)
    }

    /// let value: Float = 3.14
    /// `value.oy_cgFloat` → output → (CoreGraphics.CGFloat) 3.1400001049041748
    public var oy_cgFloat: CGFloat {
        CGFloat(self)
    }

    /// let num: Float = 3.1415927
    /// `num.oy_round(numberOfDecimal: 3, rule: .up)` → output →  3.142
    /// `num.oy_round(numberOfDecimal: 3, rule: .down)` → output →   3.141
    /// `num.oy_round(numberOfDecimal: 2, rule: .awayFromZero)` → output →   3.15
    /// `num.oy_round(numberOfDecimal: 4, rule: .towardZero)` → output →   3.1415
    /// `num.oy_round(numberOfDecimal: -1, rule: .toNearestOrEven)` → output →   3
    public func oy_round(numberOfDecimal: Int, rule: FloatingPointRoundingRule) -> Self {
        let factor = Self(pow(10.0, Double(max(0, numberOfDecimal))))
        return (self * factor).rounded(rule) / factor
    }
}
