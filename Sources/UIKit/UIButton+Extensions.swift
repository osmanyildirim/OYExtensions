//
//  UIButton+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIButton: OYInit {
    public typealias ViewType = UIButton

    /// Get and Set title of `normal` state for UIButton
    public var oy_titleForNormal: String? {
        get { title(for: .normal) }
        set(value) { setTitle(value, for: .normal) }
    }

    /// Get and Set title of `disabled` state for UIButton
    public var oy_titleForDisabled: String? {
        get { title(for: .disabled) }
        set(value) { setTitle(value, for: .disabled) }
    }

    /// Get and Set title of `highlighted` state for UIButton
    public var oy_titleForHighlighted: String? {
        get { title(for: .highlighted) }
        set(value) { setTitle(value, for: .highlighted) }
    }

    /// Get and Set title of `selected` state for UIButton
    public var oy_titleForSelected: String? {
        get { title(for: .selected) }
        set(value) { setTitle(value, for: .selected) }
    }

    /// Get and Set title color of `normal` state for UIButton
    public var oy_titleColorForNormal: UIColor? {
        get { titleColor(for: .normal) }
        set(value) { setTitleColor(value, for: .normal) }
    }

    /// Get and Set title color of `disabled` state for UIButton
    public var oy_titleColorForDisabled: UIColor? {
        get { titleColor(for: .disabled) }
        set(value) { setTitleColor(value, for: .disabled) }
    }

    /// Get and Set title color of `highlighted` state for UIButton
    public var oy_titleColorForHighlighted: UIColor? {
        get { titleColor(for: .highlighted) }
        set(value) { setTitleColor(value, for: .highlighted) }
    }

    /// Get and Set title color of `selected` state for UIButton
    public var oy_titleColorForSelected: UIColor? {
        get { titleColor(for: .selected) }
        set(value) { setTitleColor(value, for: .selected) }
    }
    
    /// Get and Set title font  for UIButton
    public var oy_titleFont: UIFont? {
        get { titleLabel?.font }
        set(value) { titleLabel?.font = value }
    }

    /// Get and Set background color of `normal` state for UIButton
    public var oy_backgroundColorForNormal: UIColor? {
        get { backgroundColor }
        set(value) { oy_setBackgroundColor(value, for: .normal) }
    }

    /// Set background color of `disabled` state for UIButton
    public var oy_backgroundColorForDisabled: UIColor? {
        get { backgroundColor }
        set(value) { oy_setBackgroundColor(value, for: .disabled) }
    }

    /// Set background color of `highlighted` state for UIButton
    public var oy_backgroundColorForHighlighted: UIColor? {
        get { backgroundColor }
        set(value) { oy_setBackgroundColor(value, for: .highlighted) }
    }

    /// Set background color of `selected` state for UIButton
    public var oy_backgroundColorForSelected: UIColor? {
        get { backgroundColor }
        set(value) { oy_setBackgroundColor(value, for: .selected) }
    }

    /// Get and Set image of `normal` state for UIButton
    public var oy_imageForNormal: UIImage? {
        get { image(for: .normal) }
        set(value) { setImage(value, for: .normal) }
    }

    /// Get and Set image of `disabled` state for UIButton
    public var oy_imageForDisabled: UIImage? {
        get { image(for: .disabled) }
        set(value) { setImage(value, for: .disabled) }
    }

    /// Get and Set image of `highlighted` state for UIButton
    public var oy_imageForHighlighted: UIImage? {
        get { image(for: .highlighted) }
        set(value) { setImage(value, for: .highlighted) }
    }

    /// Get and Set image of `selected` state for UIButton
    public var oy_imageForSelected: UIImage? {
        get { image(for: .selected) }
        set(value) { setImage(value, for: .selected) }
    }

    /// Get and Set background image of `normal` state for UIButton
    public var oy_backgroundImageForNormal: UIImage? {
        get { backgroundImage(for: .normal) }
        set(value) { setBackgroundImage(value, for: .normal) }
    }

    /// Set background image of `disabled` state for UIButton
    public var oy_backgroundImageForDisabled: UIImage? {
        get { backgroundImage(for: .disabled) }
        set(value) { setBackgroundImage(value, for: .disabled) }
    }

    /// Set background image of `highlighted` state for UIButton
    public var oy_backgroundImageForHighlighted: UIImage? {
        get { backgroundImage(for: .highlighted) }
        set(value) { setBackgroundImage(value, for: .highlighted) }
    }

    /// Set background image of `selected` state for UIButton
    public var oy_backgroundImageForSelected: UIImage? {
        get { backgroundImage(for: .selected) }
        set(value) { setBackgroundImage(value, for: .selected) }
    }

    /// Get and Set attributed title color of `normal` state for UIButton
    public var oy_attributedTitleForNormal: NSAttributedString? {
        get { attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }

    /// Get and Set attributed title color of `disabled` state for UIButton
    public var oy_attributedTitleForDisabled: NSAttributedString? {
        get { attributedTitle(for: .disabled) }
        set { setAttributedTitle(newValue, for: .disabled) }
    }

    /// Get and Set attributed title color of `highlighted` state for UIButton
    public var oy_attributedTitleForHighlighted: NSAttributedString? {
        get { attributedTitle(for: .highlighted) }
        set { setAttributedTitle(newValue, for: .highlighted) }
    }

    /// Get and Set attributed title color of `selected` state for UIButton
    public var oy_attributedTitleForSelected: NSAttributedString? {
        get { attributedTitle(for: .selected) }
        set { setAttributedTitle(newValue, for: .selected) }
    }

    /// `button.oy_touchUpInside {
    ///     // do stuff
    /// `}
    public func oy_touchUpInside(closure: @escaping() -> Void) {
        oy_event(for: .touchUpInside) {
            closure()
        }
    }

    /// `btn3.oy_addAction(action: .touchUpOutside) {
    ///     // do stuff
    /// `}
    public func oy_addAction(action: UIControl.Event, closure: @escaping() -> Void) {
        oy_event(for: action) {
            closure()
        }
    }
    
    /// remove the target/action for a set of events
    public func oy_removeTargetsAndActions() {
        removeTarget(nil, action: nil, for: .allEvents)
    }

    /// Private method of UIButton background color setters
    private func oy_setBackgroundColor(_ color: UIColor?, for state: UIControl.State = .normal) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))

        guard let context = UIGraphicsGetCurrentContext(), let color = color else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: state)
    }
}
