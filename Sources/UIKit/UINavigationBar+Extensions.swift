//
//  UINavigationBar+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension UINavigationBar {
    /// Get and Set title
    public var oy_title: String {
        get {
            topItem?.title ?? ""
        } set(value) {
            topItem?.title = value
        }
    }

    /// Get and Set title color
    public var oy_titleColor: UIColor? {
        get {
            titleTextAttributes?[.foregroundColor] as? UIColor
        } set(value) {
            guard let value else { return }
            titleTextAttributes = [.foregroundColor: value]
        }
    }

    /// Get and Set background color
    public var oy_background: UIColor? {
        get {
            backgroundColor
        } set(value) {
            guard let value else { return }
            backgroundColor = value
            isTranslucent = false
            setBackgroundImage(UIImage(), for: .default)
        }
    }

    /// Get and Set title font
    public var oy_font: UIFont? {
        get {
            titleTextAttributes?[.font] as? UIFont
        } set(value) {
            guard let value else { return }
            titleTextAttributes = [.font: value]
        }
    }

    /// Get and Set translucent
    public var oy_isTranslucent: Bool {
        get {
            isTranslucent
        }
        set(value) {
            isTranslucent = value
        }
    }

    /// Navigation bar set to transparent
    /// `navigationController?.navigationBar.oy_setTransparent()`
    public func oy_setTransparent() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = appearance
        } else {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().oy_backgroundColor = .red//.clear
            UINavigationBar.appearance().oy_isTranslucent = true
        }
    }
}
