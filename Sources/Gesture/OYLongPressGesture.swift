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

    public convenience init(minimumPressDuration: CGFloat = 0.3, completion: (() -> Void)?) {
        self.init()
        longPressAction = completion
        
        self.minimumPressDuration = minimumPressDuration
        addTarget(self, action: #selector(didLongPress(_:)))
    }

    @objc private func didLongPress(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            longPressAction?()
        }
    }
}
