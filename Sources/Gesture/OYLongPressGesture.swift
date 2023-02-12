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

final class OYLongPressGesture: UILongPressGestureRecognizer {
    private var longPressAction: (() -> Void)?

    convenience init(completion: (() -> Void)?) {
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
