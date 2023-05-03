//
//  UIScreen+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIScreen {
    /// `UIScreen.oy_main` → output → <UIScreen: 0x15cd083a0; bounds: {{0, 0}, {430, 932}}
    public static var oy_main: UIScreen {
        main
    }

    /// `UIScreen.oy_bounds` → output → (CGRect) (width = 430, height = 932)
    public static var oy_bounds: CGRect {
        main.bounds
    }

    /// `UIScreen.oy_size` → output → (CGSize) (width = 430, height = 932)
    public static var oy_size: CGSize {
        main.bounds.size
    }

    /// `UIScreen.oy_width` → output → 430.0
    public static var oy_width: CGFloat {
        oy_size.width
    }

    /// `UIScreen.oy_height` → output → 932.0
    public static var oy_height: CGFloat {
        oy_size.height
    }

    /// `UIScreen.oy_scale` → output → 3.0
    public static var oy_scale: CGFloat {
        main.scale
    }

    /// `UIScreen.oy_isRetina` → output → false
    public static var oy_isRetina: Bool {
        main.responds(to: #selector(displayLink(withTarget: selector:))) && main.scale == 2.0
    }

    /// `UIScreen.oy_isRetinaHD` → output → true
    public static var oy_isRetinaHD: Bool {
        main.responds(to: #selector(displayLink(withTarget: selector:))) && main.scale == 3.0
    }

    /// `UIScreen.oy_adjustBrightness(value: 0.5)`
    public static func oy_adjustBrightness(value: CGFloat) {
        UIScreen.main.brightness = value
    }
}
