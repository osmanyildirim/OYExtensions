//
//  OYReusable.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

public protocol OYReusable {
    /// Reuse Identifier for `UIViewController` and `UIView`
    ///
    /// `FirstViewController.oy_reuseIdentifier` → output → FirstViewController
    ///
    /// `FirstView.oy_reuseIdentifier` → output → FirstView
    ///
    /// `FirstView().oy_reuseIdentifier` → output → FirstView
    static var oy_reuseIdentifier: String { get }
}

extension OYReusable where Self: UIView {
    public static var oy_reuseIdentifier: String { oy_className }

    var oy_reuseIdentifier: String { oy_className }
}

extension OYReusable where Self: UIViewController {
    public static var oy_reuseIdentifier: String {
        return oy_className
    }
}

extension UIView: OYReusable { }
extension UIViewController: OYReusable { }
