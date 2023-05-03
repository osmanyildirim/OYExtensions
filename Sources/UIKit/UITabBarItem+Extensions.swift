//
//  UITabBarItem+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UITabBarItem {
    /// Set badge count of UITabBarItem
    public func oy_set(badgeCount: Int) {
        badgeValue = badgeCount.oy_string
    }
    
    /// Set badge color of UITabBarItem
    public func oy_set(badgeColor: UIColor) {
        self.badgeColor = badgeColor
    }
}
