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
/// Remove Pan gesture:
///
///         panGesture.remove()
///

public final class OYPanGesture: UIPanGestureRecognizer, OYBaseGesture {
    private var panAction: (() -> Void)?

    public convenience init(completion: (() -> Void)?) {
        self.init()
        panAction = completion
        addTarget(self, action: #selector(didPan))
    }

    @objc private func didPan() {
        panAction?()
    }
}
