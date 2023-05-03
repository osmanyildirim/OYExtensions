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
    
    /// Hide navigation controller bars when the keyboard appears
    public func oy_hideWhenKeyboardAppears(_ isHide: Bool) {
        hidesBarsWhenKeyboardAppears = isHide
    }

    /// Get and Set translucent
    public var oy_isTranslucent: Bool {
        get {
            navigationBar.isTranslucent
        }
        set(value) {
            navigationBar.isTranslucent = value
        }
    }
    
    /// Get and Set title
    public var oy_title: String {
        get {
            navigationBar.oy_title
        }
        set(value) {
            navigationBar.oy_title = value
        }
    }
    
    /// Get and Set title color
    public var oy_titleColor: UIColor? {
        get {
            navigationBar.oy_titleColor
        }
        set(value) {
            navigationBar.oy_titleColor = value
        }
    }
    
    /// Get and Set background color
    public var oy_backgroundColor: UIColor? {
        get {
            navigationBar.oy_backgroundColor
        }
        set(value) {
            navigationBar.oy_backgroundColor = value
        }
    }

    /// Get and Set title font
    public var oy_titleFont: UIFont? {
        get {
            navigationBar.oy_font
        }
        set(value) {
            navigationBar.oy_font = value
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
