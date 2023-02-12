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

final class OYPinchGesture: UIPinchGestureRecognizer {
    private var pinchAction: (() -> Void)?

    convenience init(completion: (() -> Void)?) {
        self.init()
        pinchAction = completion
        addTarget(self, action: #selector(didPinch))
    }

    @objc private func didPinch() {
        pinchAction?()
    }
}
