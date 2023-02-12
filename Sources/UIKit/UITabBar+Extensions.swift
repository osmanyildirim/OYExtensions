//
//  UITabBar+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UITabBar: OYInit {
    public typealias ViewType = UITabBar

    /// Set height in view of UITabBar
    public func oy_set(height: CGFloat, in view: UIView) {
        var frame = frame.copy(height: height)
        frame.oy_y = view.frame.oy_height - height
        self.frame = frame
    }

    /// Height of UITabBar
    public var oy_height: CGFloat {
        bounds.height
    }
}
