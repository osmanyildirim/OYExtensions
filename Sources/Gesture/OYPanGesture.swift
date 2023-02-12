//
//  OYPanGesture.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

/// Pan gesture with `completion handler`
///
/// Usage:
///
///         let panGesture = OYPanGesture {
///             // do stuff
///         }
///         sampleView.addGestureRecognizer(panGesture)
///

final class OYPanGesture: UIPanGestureRecognizer {
    private var panAction: (() -> Void)?

    convenience init(completion: (() -> Void)?) {
        self.init()
        panAction = completion
        addTarget(self, action: #selector(didPan))
    }

    @objc private func didPan() {
        panAction?()
    }
}
