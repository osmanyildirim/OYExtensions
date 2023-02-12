//
//  CGPoint+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension CGPoint {
    /// `CGPoint.oy_init(0, 10)` → output → (0.0, 10.0)
    public static func oy_init(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        CGPoint(x: x, y: y)
    }

    /// let value = CGPoint(x: 0, y: 10)
    /// `value.oy_x` → output → 0.0
    public var oy_x: CGFloat {
        get { x }
        set(value) { x = value }
    }

    /// let value = CGPoint(x: 0, y: 10)
    /// `value.oy_y` → output → 10.0
    public var oy_y: CGFloat {
        get { y }
        set(value) { y = value }
    }

    /// let value = CGPoint(x: 0, y: 10)
    /// `value.oy_copy(x: 50)` → output → (50.0, 10.0)
    public func oy_copy(x: CGFloat) -> CGPoint {
        CGPoint(x: x, y: self.y)
    }

    /// let value = CGPoint(x: 0, y: 10)
    /// `value.oy_copy(y: 50)` → output → (0.0, 50.0)
    public func oy_copy(y: CGFloat) -> CGPoint {
        CGPoint(x: self.x, y: y)
    }

    /// let refPoint = CGPoint(x: 0, y: 10)
    /// let destPoint = CGPoint(x: 30, y: 50)
    /// `refPoint.oy_distance(destPoint)` → output → 50
    public func oy_distance(_ point: CGPoint) -> CGFloat {
        sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }

    /// let refPoint = CGPoint(x: 0, y: 10)
    /// let destPoint = CGPoint(x: 30, y: 50)
    /// `refPoint.oy_difference(destPoint)`→ output → (-30.0, -40.0)
    public func oy_difference (_ rhs: CGPoint) -> CGPoint {
        CGPoint(x: self.x - rhs.x, y: self.y - rhs.y)
    }

    /// let refPoint = CGPoint(x: 0, y: 10)
    /// let destPoint = CGPoint(x: 30, y: 50)
    /// `refPoint.oy_add(destPoint)`→ output → (30.0, 60.0)
    public func oy_add(_ rhs: CGPoint) -> CGPoint {
        CGPoint(x: self.x + rhs.x, y: self.y + rhs.y)
    }
}
