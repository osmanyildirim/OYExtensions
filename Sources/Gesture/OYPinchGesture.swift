//
//  OYPinchGesture.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

/// Pinch gesture with `completion handler`
///
/// Usage:
///
///         let pinchGesture = OYPinchGesture {
///             // do stuff
///         }
///         sampleView.addGestureRecognizer(pinchGesture)
///
/// Remove Pinch gesture:
///
///         pinchGesture.remove()
///

public final class OYPinchGesture: UIPinchGestureRecognizer, OYBaseGesture {
    private var pinchAction: (() -> Void)?

    public convenience init(completion: (() -> Void)?) {
        self.init()
        pinchAction = completion
        addTarget(self, action: #selector(didPinch))
    }

    @objc private func didPinch() {
        pinchAction?()
    }
}
