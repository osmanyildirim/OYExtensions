//
//  UIColor+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIColor {
    /// `UIColor.oy_init(hex: "#AD2131")`
    public static func oy_init(hex: String) -> UIColor {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    /// `UIColor.oy_init(red: 173, green: 33, blue: 49)`
    public static func oy_init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

    /// `UIColor.oy_init(gray: 127.5)`
    public static func oy_init(gray: CGFloat, alpha: CGFloat = 1) -> UIColor {
        UIColor(red: gray / 255, green: gray / 255, blue: gray / 255, alpha: alpha)
    }

    /// `UIColor.oy_random`
    public static var oy_random: UIColor {
        UIColor.oy_init(red: .oy_random, green: .oy_random, blue: .oy_random, alpha: .oy_random)
    }

    /// `color.oy_rgba`→ output → (red: 173.0, green: 33.0, blue: 49.0, alpha: 1.0)
    public var oy_rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red * 255, green * 255, blue * 255, alpha)
    }

    /// `color.oy_alpha`→ output → 1.0
    public var oy_alpha: CGFloat {
        var alpha: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
    }

    /// `color.oy_red`→ output → 173.0
    public var oy_red: CGFloat {
        var red: CGFloat = 0.0
        getRed(&red, green: nil, blue: nil, alpha: nil)

        return red * 255
    }

    /// `color.oy_green`→ output → 33.0
    public var oy_green: CGFloat {
        var green: CGFloat = 0.0
        getRed(nil, green: &green, blue: nil, alpha: nil)

        return green * 255
    }

    /// `color.oy_blue`→ output → 49.0
    public var oy_blue: CGFloat {
        var blue: CGFloat = 0.0
        getRed(nil, green: nil, blue: &blue, alpha: nil)

        return blue * 255
    }

    /// `color.oy_dark`
    @available(iOS 13.0, *) public var oy_dark: UIColor {
        resolvedColor(with: .init(userInterfaceStyle: .dark))
    }

    /// `color.oy_light`
    @available(iOS 13.0, *) public var oy_light: UIColor {
        resolvedColor(with: .init(userInterfaceStyle: .light))
    }

    /// `color.oy_lighter(by: 20)`
    public func oy_lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        adjust(by: abs(percentage))
    }

    /// `color.oy_darker(by: 30)`
    public func oy_darker(by percentage: CGFloat = 30.0) -> UIColor? {
        adjust(by: -1 * abs(percentage))
    }

    /// Private method for lighter and darker actions
    private func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage / 100, 1.0),
                green: min(green + percentage / 100, 1.0),
                blue: min(blue + percentage / 100, 1.0),
                alpha: alpha)
        } else {
            return nil
        }
    }
}
