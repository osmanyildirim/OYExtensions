//
//  OYBaseGesture.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

public protocol OYBaseGesture {
    /// Detaches a gesture recognizer from the receiving view
    func remove()
}

extension OYBaseGesture where Self: UIGestureRecognizer {
    public func remove() {
        view?.removeGestureRecognizer(self)
    }
}
