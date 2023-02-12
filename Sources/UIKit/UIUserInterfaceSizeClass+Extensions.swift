//
//  UIUserInterfaceSizeClass+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIUserInterfaceSizeClass {
    /// `self.traitCollection.verticalSizeClass.oy_string` → output → "Regular"
    public var oy_string: String {
        switch rawValue {
        case 1: return "Compact"
        case 2: return "Regular"
        default: return "Unspecified"
        }
    }
}
