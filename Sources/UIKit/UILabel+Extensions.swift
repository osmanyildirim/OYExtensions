//
//  UILabel+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UILabel: OYInit {
    public typealias ViewType = UILabel

    /// Initializer method with `x, y, width, height and text` values
    public static func oy_init(_ x: CGFloat = 0, _ y: CGFloat = 0, _ width: CGFloat = 0, _ height: CGFloat = 0, text: String) -> UILabel {
        let label: UILabel = oy_init(x: x, y: y, width: width, height: height)
        label.text = text
        return label
    }

    /// Set text with animation
    /// - Parameters:
    ///   - text: Text
    ///   - animated: if the should be animated
    ///   - duration: animation duration
    public func oy_setText(_ text: String, animated: Bool = true, duration: TimeInterval = 0.5) {
        self.text = text

        guard animated else { return }

        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }

    /// Estimated size of UILabel
    public func oy_estimatedSize(width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        sizeThatFits(CGSize(width: width, height: height))
    }

    /// Estimated width of UILabel
    public var oy_estimatedWidth: CGFloat {
        sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: frame.height)).width
    }

    /// Estimated height of UILabel
    public var oy_estimatedHeight: CGFloat {
        sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)).height
    }

    /// Set fit width of UILabel
    public func oy_fitWidth(minimumWidth: CGFloat? = nil) {
        let minimumWidth = minimumWidth ?? frame.width
        let width = oy_estimatedWidth < minimumWidth ? minimumWidth : oy_estimatedWidth
        frame.oy_width = width
    }

    /// Set fit height of UILabel
    public func oy_fitHeight(minimumHeight: CGFloat? = nil) {
        let minimumHeight = minimumHeight ?? frame.height
        let height = oy_estimatedHeight < minimumHeight ? minimumHeight : oy_estimatedHeight
        frame.oy_height = height
    }
}
