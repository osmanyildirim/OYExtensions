//
//  Double+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Double {
    /// let value: Double = 3.14
    /// `value.oy_string` → output → (String) "3.14"
    public var oy_string: String {
        String(self)
    }

    /// let value: Double = 3.14
    /// `value.oy_string_1f` → output → (String) "3.1"
    public var oy_string_1f: String {
        String(format: "%.1f", self)
    }

    /// let value: Double = 3.14
    /// `value.oy_string_2f` → output → (String) "3.14"
    public var oy_string_2f: String {
        String(format: "%.2f", self)
    }

    /// let value: Double = 3.14
    /// `value.oy_int` → output → (Int) 3
    public var oy_int: Int {
        Int(self)
    }

    /// let value: Double = 3.14
    /// `value.oy_cgFloat` → output → (CGFloat) 3.14
    public var oy_cgFloat: CGFloat {
        CGFloat(self)
    }

    /// let value: Double = 3.14
    /// `value.oy_float` → output → (Float) 3.14
    public var oy_float: Float {
        Float(self)
    }

    /// let value: Double = 180.0
    /// `value.oy_degreesToRadians` → output → (Double) 3.1415926535897931
    public var oy_degreesToRadians: Double {
        Double.pi * Double(self) / 180.0
    }

    /// let value: Double = 3.14
    /// `value.oy_radiansToDegrees` → output → (Float) 179.90874767107852
    public var oy_radiansToDegrees: Double {
        Double(self) * 180 / Double.pi
    }

    /// `0.123.oy_oneDigit` → output → 0.1
    public var oy_oneDigit: Double {
        floor(self * 10) / 10
    }

    /// `2000.oy_distanceFormat` → output → 2 km
    /// `2100.oy_distanceFormat` → output → 2.1 km
    /// `2149.oy_distanceFormat` → output → 2.1 km
    /// `990.oy_distanceFormat` → output → 990 m
    public var oy_distanceFormat: String {
        if self < 1_000 {
            return String(oy_int) + " m"
        } else if self.truncatingRemainder(dividingBy: 1_000) == 0 {
            return String((self / 1_000).oy_int) + " km"
        } else {
            return String((self / 1_000).oy_oneDigit) + " km"
        }
    }
}
