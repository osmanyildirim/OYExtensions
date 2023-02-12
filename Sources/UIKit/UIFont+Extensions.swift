//
//  UIFont+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIFont {
    /// System font initializer method
    /// - Parameter size: font size
    /// - Returns: system font
    public static func oy_systemFont(ofSize size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size)
    }

    /// Font as bold
    public var oy_bold: UIFont {
        UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// Font as italic
    public var oy_italic: UIFont {
        UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }

    /// Font as mono space
    public var oy_monoSpace: UIFont {
        UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitMonoSpace)!, size: 0)
    }

    /// Check that the font is bold
    public var oy_isBold: Bool {
        fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    /// Check that the font is italic
    public var oy_isItalic: Bool {
        fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

    /// Check that the font is mono space
    public var oy_isMonoSpace: Bool {
        fontDescriptor.symbolicTraits.contains(.traitMonoSpace)
    }

    /// Font's weight
    public var oy_weight: CGFloat? {
        guard let traits = self.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.traits) as? [String: Any]
            else { return nil }
        return traits[UIFontDescriptor.TraitKey.weight.rawValue] as? CGFloat
    }

    /// Print fonts name(s) in App's
    public static func oy_printFonts() {
        for familyName in familyNames {
            print("family: \(familyName)\n")

            for fontName in fontNames(forFamilyName: familyName) {
                print("font: \(fontName)")
            }
        }
    }
}
