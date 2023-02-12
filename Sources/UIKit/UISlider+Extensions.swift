//
//  UISlider+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UISlider: OYInit {
    public typealias ViewType = UISlider

    /// `slider.oy_set(value: 10, animated: true, duration: 2) {
    ///     // do stuff
    /// `}
    public func oy_set(value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                    completion?()
                })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }
}
