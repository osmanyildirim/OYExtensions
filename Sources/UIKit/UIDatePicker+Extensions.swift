//
//  UIDatePicker+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIDatePicker: OYInit {
    public typealias ViewType = UIDatePicker

    /// Initializer method with `x, y, width, height` values
    public static func oy_init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> UIDatePicker {
        let datePicker = UIDatePicker(frame: .oy_init(x, y, width, height))
        return datePicker
    }

    /// Get and Set text color of UIDatePicker
    public var oy_textColor: UIColor? {
        get { value(forKeyPath: "textColor") as? UIColor }
        set(value) { setValue(value, forKeyPath: "textColor") }
    }

    /// Get and Set indicator color of UIDatePicker
    public var oy_indicatorColor: UIColor? {
        get {
            guard !subviews.isEmpty else { return nil }

            if subviews[0].subviews.count > 1 {
                return subviews[0].subviews[1].backgroundColor
            }
            return nil
        }
        set(value) {
            guard !subviews.isEmpty else { return }

            if subviews[0].subviews.count > 1 {
                subviews[0].subviews[1].backgroundColor = value
            }
            if subviews[0].subviews.count > 2 {
                subviews[0].subviews[2].backgroundColor = value
            }
        }
    }
}
