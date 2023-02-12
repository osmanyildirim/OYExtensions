//
//  OYInit.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

public protocol OYInit {
    /// Generic base associated type for `oy_init()` initializer method
    associatedtype ViewType: UIView

    /// Generic initializer method
    static func oy_init() -> ViewType

    /// Generic initializer method with `frame`
    static func oy_init(frame: CGRect) -> ViewType

    /// Generic initializer method with `x,y,width,height` values
    static func oy_init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> ViewType
}

extension OYInit {
    public static func oy_init() -> ViewType {
        ViewType()
    }

    public static func oy_init(frame: CGRect) -> ViewType {
        ViewType(frame: frame)
    }

    public static func oy_init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> ViewType {
        ViewType(frame: .oy_init(x, y, width, height))
    }
}
