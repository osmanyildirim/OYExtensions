//
//  UIRectCorner+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension UIRectCorner {
    public var caCornerMask: CACornerMask {
        switch self {
        case .topLeft:
            return .layerMinXMinYCorner
        case .bottomLeft:
            return .layerMinXMaxYCorner
        case .topRight:
            return .layerMaxXMinYCorner
        case .bottomRight:
            return .layerMaxXMaxYCorner
        default:
            return []
        }
    }
}
