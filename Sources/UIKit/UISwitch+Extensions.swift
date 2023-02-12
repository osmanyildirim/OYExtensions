//
//  UISwitch+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UISwitch: OYInit {
    public typealias ViewType = UISwitch

    /// Initializer method with `isOn` value
    public static func oy_init(isOn: Bool) -> UISwitch {
        let uiSwitch: UISwitch = oy_init()
        uiSwitch.isOn = isOn
        return uiSwitch
    }

    /// Get and Set `isOn` and fire `valueChanged` event
    public var oy_isOn: Bool {
        get { isOn }
        set(value) {
            isOn = value
            sendActions(for: .valueChanged)
        }
    }

    /// Get and Set thumbTintColor
    public var oy_thumbColor: UIColor? {
        get { thumbTintColor }
        set(value) { thumbTintColor = value }
    }

    /// Get and Set ON state's tint color
    public var oy_onColor: UIColor? {
        get { onTintColor }
        set(value) { onTintColor = value }
    }

    /// Get and Set OFF state's tint color
    public var oy_offColor: UIColor? {
        get { tintColor }
        set(value) {
            tintColor = value
            backgroundColor = value
            layer.cornerRadius = frame.height / 2.0
        }
    }

    /// ON/OFF value toggle
    public func oy_toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
        sendActions(for: .valueChanged)
    }

    /// Observe `.valueChanged` event
    public func oy_valueChange(closure: @escaping () -> Void) {
        oy_event(for: .valueChanged) {
            closure()
        }
    }
}
