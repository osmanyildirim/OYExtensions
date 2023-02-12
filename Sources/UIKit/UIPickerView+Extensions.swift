//
//  UIPickerView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIPickerView: OYInit {
    public typealias ViewType = UIPickerView

    /// Get and Set text color of UIPickerView
    public var oy_textColor: UIColor? {
        get { value(forKeyPath: "textColor") as? UIColor }
        set(value) { setValue(value, forKeyPath: "textColor") }
    }

    /// Get and Set indicator color of UIPickerView
    public var oy_indicatorColor: UIColor? {
        get {
            guard !subviews.isEmpty else { return nil }

            if subviews.count > 1 && subviews[0].subviews.count > 1 {
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
