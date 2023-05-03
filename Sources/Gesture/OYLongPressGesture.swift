//
//  OYLongPressGesture.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

/// Long press gesture with `completion handler`
///
/// Usage:
///
///         let longPressGesture = OYLongPressGesture {
///             // do stuff
///         }
///         sampleView.addGestureRecognizer(longPressGesture)
///
/// Remove Long press gesture:
///
///         longPressGesture.remove()
///

public final class OYLongPressGesture: UILongPressGestureRecognizer, OYBaseGesture {
    private var longPressAction: (() -> Void)?

    public convenience init(completion: (() -> Void)?) {
        self.init()
        longPressAction = completion
        addTarget(self, action: #selector(didLongPress(_:)))
    }

    @objc private func didLongPress(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            longPressAction?()
        }
    }
}
