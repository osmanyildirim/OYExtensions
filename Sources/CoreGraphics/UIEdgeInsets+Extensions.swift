//
//  UIEdgeInsets+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIEdgeInsets {
    /// `UIEdgeInsets.oy_init(0, 10, 20, 30)` → output → UIEdgeInsets(top: 0.0, left: 10.0, bottom: 20.0, right: 30.0)
    public static func oy_init(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /// let value = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 30)
    /// `value.oy_top` → output → 0.0
    public var oy_top: CGFloat {
        get { top }
        set(value) { top = value }
    }

    /// let value = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 30)
    /// `value.oy_bottom` → output → 20.0
    public var oy_bottom: CGFloat {
        get { bottom }
        set(value) { bottom = value }
    }

    /// let value = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 30)
    /// `value.oy_left` → output → 10.0
    public var oy_left: CGFloat {
        get { self.left }
        set(value) { self.left = value }
    }

    /// let value = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 30)
    /// `value.oy_right` → output → 30.0
    public var oy_right: CGFloat {
        get { self.right }
        set(value) { self.right = value }
    }
}
