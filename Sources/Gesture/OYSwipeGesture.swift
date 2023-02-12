//
//  OYSwipeGesture.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

/// Swipe gesture with `direction, touchCount, completion handler`
///
/// Usage:
///
///         let swipeGesture = OYSwipeGesture(direction: .up, touchCount: 1) {
///             // do stuff
///         }
///         sampleView.addGestureRecognizer(swipeGesture)
///

final class OYSwipeGesture: UISwipeGestureRecognizer {
    private var swipeAction: (() -> Void)?

    convenience init(direction: UISwipeGestureRecognizer.Direction, touchCount: Int = 1, completion: (() -> Void)?) {
        self.init()
        self.direction = direction

        #if os(iOS)
            numberOfTouchesRequired = touchCount
        #endif
        swipeAction = completion
        addTarget(self, action: #selector(didSwipe))
    }

    @objc private func didSwipe() {
        swipeAction?()
    }
}
