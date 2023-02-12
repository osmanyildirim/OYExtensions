//
//  UIControl+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIControl {
    /// `button.oy_event(for: .touchUpInside) {
    ///     // do stuff
    /// `}
    public func oy_event(for event: UIControl.Event, completion: @escaping() -> Void) {
        if #available(iOS 14.0, *) {
            addAction(UIAction { _ in completion() }, for: event)
        } else {
            @objc class Closure: NSObject {
                let closure: () -> Void
                init(_ closure: @escaping() -> Void) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let closure = Closure(completion)
            addTarget(closure, action: #selector(Closure.invoke), for: event)
            objc_setAssociatedObject(self, "\(UUID())", closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
