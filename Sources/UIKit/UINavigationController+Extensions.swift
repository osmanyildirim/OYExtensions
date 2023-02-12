//
//  UINavigationController+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UINavigationController {
    /// Push ViewController with completion handler
    public override func oy_push(viewControler: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewControler, animated: true)
        CATransaction.commit()
    }

    /// Pop ViewController with completion handler
    public override func oy_pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }

    /// Pop to root ViewController with completion handler
    public override func oy_popToRoot(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }

    /// Pop to ViewController with completion handler
    public override func oy_popTo(viewControler: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToViewController(viewControler, animated: animated)
        CATransaction.commit()
    }

    /// Show navigation bar
    public func oy_show(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    /// Hide navigation bar
    public func oy_hide(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    /// Set navigation bar's background color and text color
    public func oy_set(backgroundColor: UIColor, textColor: UIColor) {
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = backgroundColor
        navigationBar.barTintColor = backgroundColor
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.tintColor = textColor
        navigationBar.titleTextAttributes = [.foregroundColor: textColor]
    }

    /// Set navigation bar's transparency with tint color
    public func oy_setTransparent(tintColor: UIColor) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
    }

    /// Get and Set title color for UINavigationBar
    public var oy_titleColor: UIColor? {
        get {
            return navigationBar.titleTextAttributes?[.foregroundColor] as? UIColor
        }
        set {
            if navigationBar.titleTextAttributes == nil {
                navigationBar.titleTextAttributes = [:]
            }
            navigationBar.titleTextAttributes?[.foregroundColor] = newValue
        }
    }

    /// Get and Set title font for UINavigationBar
    public var oy_titleFont: UIFont? {
        get {
            return navigationBar.titleTextAttributes?[.font] as? UIFont
        }
        set {
            if navigationBar.titleTextAttributes == nil {
                navigationBar.titleTextAttributes = [:]
            }
            navigationBar.titleTextAttributes?[.font] = newValue
        }
    }

    /// UINavigationBar height
    public var oy_height: CGFloat {
        navigationBar.bounds.height
    }

    /// Change UINavigationBar's button colors
    public func oy_changeButtonsColors(color: UIColor) {
        UINavigationBar.appearance().tintColor = color
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color]

    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    private static var gesture = UIPanGestureRecognizer()

    /// Enable pop gesture for UINavigationController
    /// - Parameter fromAnywhere: if true will be pop from screen's anyhwere
    public func oy_enablePopGesture(fromAnywhere: Bool = false) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        guard fromAnywhere, let gesture = navigationController?.interactivePopGestureRecognizer, let targets = gesture.value(forKey: "targets") as? NSMutableArray else { return }

        Self.gesture.setValue(targets, forKey: "targets")
        view.addGestureRecognizer(Self.gesture)
    }

    /// Disable pop gesture for UINavigationController
    public func oy_disablePopGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.removeGestureRecognizer(Self.gesture)
    }
}
