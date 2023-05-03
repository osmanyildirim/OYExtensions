//
//  UISegmentedControl+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension UISegmentedControl: OYInit {
    public typealias ViewType = UISegmentedControl

    /// Initializer method with `items` value
    public static func oy_init(items: String...) -> UISegmentedControl {
        UISegmentedControl(items: items)
    }

    /// Set selected index of UISegmentedControl
    public func oy_set(index: Int) {
        selectedSegmentIndex = index
    }

    /// Set selected tint color of UISegmentedControl
    @available(iOS 13.0, *) public func oy_set(selectedColor: UIColor) {
        selectedSegmentTintColor = selectedColor
    }
}
