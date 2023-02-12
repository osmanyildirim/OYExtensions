//
//  OYHandlerButton.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

/// Handler button with completion handler
///
/// Usage:
///
///         let button = OYHandlerButton()
///         button.didTouchUpInside = {
///             // do stuff
///         }
public final class OYHandlerButton: UIButton {
    @objc public var didTouchUpInside: (() -> Void)? {
        didSet {
            guard didTouchUpInside != nil else {
                removeTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
                return
            }
            addTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
        }
    }

    @objc private func didTouchUpInside(_ sender: UIButton) {
        didTouchUpInside?()
    }
}
