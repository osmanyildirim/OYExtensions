//
//  Constraint+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension NSLayoutConstraint {
    /// var constraint = NSLayoutConstraint()
    /// `constraint.oy_update(constant: 120)`
    public func oy_update(constant value: CGFloat) {
        if constant != value {
            constant = value
        }
    }

    /// var constraint = NSLayoutConstraint()
    /// `constraint.oy_update(constant: 120, view: self.view, duration: 1)`
    public func oy_update(constant: CGFloat, view: UIView?, duration: TimeInterval = 0.5) {
        if self.constant != constant {
            self.constant = constant
        }

        UIView.animate(withDuration: duration, delay: 0, options: .layoutSubviews, animations: { })
    }

    /// var constraint = NSLayoutConstraint()
    /// `constraint.oy_update(priority: .defaultHigh)`
    public func oy_update(priority value: UILayoutPriority) {
        if priority != value {
            priority = value
        }
    }
}
