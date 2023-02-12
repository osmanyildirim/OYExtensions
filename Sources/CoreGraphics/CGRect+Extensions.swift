//
//  CGRect+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension CGRect {
    /// `CGRect.oy_init(0, 10, 100, 200)` → output → (0.0, 10.0, 100.0, 200.0)
    public static func oy_init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_center` → output → (50.0, 110.0)
    public var oy_center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_x` → output → 0.0
    public var oy_x: CGFloat {
        get { origin.x }
        set(value) { origin.x = value }
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_y` → output → 10.0
    public var oy_y: CGFloat {
        get { origin.y }
        set(value) { origin.y = value }
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_width` → output → 100.0
    public var oy_width: CGFloat {
        get { width }
        set(value) { size.width = value }
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_height` → output → 200.0
    public var oy_height: CGFloat {
        get { height }
        set(value) { size.height = value }
    }

    /// let value = CGRect(x: 20, y: 10, width: 100, height: 200)
    /// `value.oy_maxX` → output → 120.0
    public var oy_maxX: CGFloat {
        maxX
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_maxY` → output → 210.0
    public var oy_maxY: CGFloat {
        maxY
    }

    /// let value = CGRect(x: 20, y: 10, width: 100, height: 200)
    /// `value.oy_minX` → output → 20.0
    public var oy_minX: CGFloat {
        minX
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_minY` → output → 10.0
    public var oy_minY: CGFloat {
        minY
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_topLeft` → output → (0.0, 10.0)
    public var oy_topLeft: CGPoint {
        return origin
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_topRight` → output → (100.0, 10.0)
    public var oy_topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_bottomLeft` → output → (0.0, 210.0)
    public var oy_bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_bottomRight` → output → (100.0, 210.0)
    public var oy_bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_contains(it: CGRect(x: 10, y: 10, width: 10, height: 20))` → output → true
    public func oy_contains(it: CGRect) -> Bool {
        contains(it)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_copy(x: 50)` → output → (50.0, 10.0, 100.0, 200.0)
    public func copy(x: CGFloat) -> CGRect {
        CGRect(x: x, y: origin.y, width: width, height: height)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_copy(y: 50)` → output → (0.0, 50.0, 100.0, 200.0)
    public func copy(y: CGFloat) -> CGRect {
        CGRect(x: origin.x, y: y, width: width, height: height)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_copy(width: 50)` → output → (0.0, 10.0, 50.0, 200.0)
    public func copy(width: CGFloat) -> CGRect {
        CGRect(x: origin.x, y: origin.y, width: width, height: height)
    }

    /// let value = CGRect(x: 0, y: 10, width: 100, height: 200)
    /// `value.oy_copy(height: 50)` → output → (0.0, 10.0, 100.0, 50.0)
    public func copy(height: CGFloat) -> CGRect {
        CGRect(x: origin.x, y: origin.y, width: width, height: height)
    }
}
