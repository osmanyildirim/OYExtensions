//
//  NSObject+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension NSObject {
    /// let instance = ClassSample()
    /// `instance.oy_className` → output →  "ClassSample"
    @objc public var oy_className: String {
        type(of: self).description().components(separatedBy: ".").last ?? ""
    }
    
    /// `ClassSample.oy_className`  → output →  "ClassSample"
    public static var oy_className: String {
        String(describing: self)
    }
}
