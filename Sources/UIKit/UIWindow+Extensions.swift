//
//  UIWindow+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIWindow {
    /// Initializer method with `viewController`
    public static func oy_init(_ viewController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        return window
    }

    /// `UIWindow.oy_size` → output → (width = 430, height = 932)
    public static var oy_size: CGRect {
        UIScreen.main.bounds
    }

    /// `UIWindow.oy_width` → output → 430
    public static var oy_width: CGFloat {
        UIScreen.main.bounds.width
    }

    /// `UIWindow.oy_height` → output → 932
    public static var oy_height: CGFloat {
        UIScreen.main.bounds.height
    }

    /// `UIWindow.oy_safeAreaTop` → output → 59
    public static var oy_safeAreaTop: CGFloat {
        UIApplication.oy_keyWindow?.safeAreaInsets.top ?? 0
    }

    /// `UIWindow.oy_safeAreaBottom` → output → 34
    public static var oy_safeAreaBottom: CGFloat {
        UIApplication.oy_keyWindow?.safeAreaInsets.bottom ?? 0
    }
}
