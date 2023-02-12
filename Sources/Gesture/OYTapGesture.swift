//
//  OYTapGesture.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

/// Pan gesture with `tapCount, touchCount, completion handler`
///
/// Usage:
///
///         let tapGesture = OYTapGesture(tapCount: 1, touchCount: 1) {
///             // do stuff
///         }
///         sampleView.addGestureRecognizer(tapGesture)
///

final class OYTapGesture: UITapGestureRecognizer {
    private var tapAction: (() -> Void)?

    convenience init(tapCount: Int = 1, touchCount: Int = 1, completion: (() -> Void)?) {
        self.init()
        numberOfTapsRequired = tapCount

        #if os(iOS)
            numberOfTouchesRequired = touchCount
        #endif
        tapAction = completion
        addTarget(self, action: #selector(didTap))
    }

    @objc private func didTap() {
        tapAction?()
    }
}
