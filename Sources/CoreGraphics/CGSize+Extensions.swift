//
//  CGSize+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension CGSize {
    /// `CGSize.oy_init(0, 10)` → output → (0.0, 10.0)
    public static func oy_init(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        CGSize(width: width, height: height)
    }

    /// let value = CGSize(width: 100, height: 200)
    /// `value.oy_width` → output → 100.0
    public var oy_width: CGFloat {
        get { width }
        set(value) { width = value }
    }

    /// let value = CGSize(width: 100, height: 200)
    /// `value.oy_height` → output → 200.0
    public var oy_height: CGFloat {
        get { height }
        set(value) { height = value }
    }

    /// let value = CGSize(width: 100, height: 200)
    /// `value.oy.copy(width: 50)` → output → (50.0, 200.0)
    public func copy(width: CGFloat) -> CGSize {
        CGSize(width: width, height: height)
    }

    /// let value = CGSize(width: 100, height: 200)
    /// `value.oy.copy(height: 50)` → output → (100.0, 50.0)
    public func copy(height: CGFloat) -> CGSize {
        CGSize(width: width, height: height)
    }
}
