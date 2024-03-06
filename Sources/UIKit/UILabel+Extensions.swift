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

    /// Get and Set text color of UILabel
    public var oy_textColor: UIColor? {
        get { textColor }
        set(value) { textColor = value }
    }
    
    /// Set text with animation
    /// - Parameters:
    ///   - text: Text
    ///   - animated: if the should be animated
    ///   - duration: animation duration
    public func oy_set(text: String?, animated: Bool = true, duration: TimeInterval = 0.5) {
        self.text = text

        guard animated else { return }

        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    /// Get and Set font of UILabel
    public var oy_font: UIFont? {
        get { font }
        set(value) { font = value }
    }
    
    /// Get and Set text alignment of UILabel
    public var oy_textAlignment: NSTextAlignment {
        get { textAlignment }
        set(value) { textAlignment = value }
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

    /// Set frame by estimated width of UILabel
    public func oy_setFitWidth(minimumWidth: CGFloat? = nil) {
        let minimumWidth = minimumWidth ?? frame.width
        let width = oy_estimatedWidth < minimumWidth ? minimumWidth : oy_estimatedWidth
        frame.oy_width = width
    }

    /// Set frame by estimated height of UILabel
    public func oy_setFitHeight(minimumHeight: CGFloat? = nil) {
        let minimumHeight = minimumHeight ?? frame.height
        let height = oy_estimatedHeight < minimumHeight ? minimumHeight : oy_estimatedHeight
        frame.oy_height = height
    }
    
    /// Spaces between letters
    public var oy_lettersSpace: CGFloat {
        get {
            if let attributedText = attributedText?.attribute(.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return attributedText
            } else {
                return 0
            }
        } set(value) {
            let attributedString: NSMutableAttributedString?
            if let attributedText {
                attributedString = NSMutableAttributedString(attributedString: attributedText)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            guard let attributedString else { return }
            attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    /// Spaces between lines
    /// - Parameter linesSpace: space value
    public func oy_set(linesSpace: CGFloat) {
        guard let text else { return }
        let textAlignment = textAlignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linesSpace
        let attributedString = NSAttributedString(string: text, attributes: [.paragraphStyle: paragraphStyle])
        self.attributedText = attributedString
        self.textAlignment = textAlignment
    }
}
