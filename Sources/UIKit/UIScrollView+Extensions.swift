//
//  UIScrollView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIScrollView {
    /// Get and Set contentSize width of UIScrollView
    public var oy_contentSizeWidth: CGFloat {
        get { contentSize.width }
        set(value) { contentSize = .oy_init(value, contentSize.height) }
    }

    /// Get and Set contentSize height of UIScrollView
    public var oy_contentSizeHeight: CGFloat {
        get { contentSize.height }
        set(value) { contentSize = .oy_init(contentSize.width, value) }
    }

    /// Get and Set contentOffset of UIScrollView
    public var oy_contentOffset: CGPoint {
        get { contentOffset }
        set(value) { contentOffset = value }
    }

    /// Get and Set contentOffset X coordinate of UIScrollView
    public var oy_contentOffsetX: CGFloat {
        get { contentOffset.x }
        set(value) { setContentOffset(.oy_init(value, oy_contentOffsetY), animated: true) }
    }

    /// Get and Set contentOffset Y coordinate of UIScrollView
    public var oy_contentOffsetY: CGFloat {
        get { contentOffset.y }
        set(value) { setContentOffset(.oy_init(oy_contentOffsetX, value), animated: true) }
    }

    /// Set UIScrollView contentOffset
    /// - Parameters:
    ///   - x: contentOffset X coordinate
    ///   - y: contentOffset Y coordinate
    ///   - duration: animation duration
    ///   - options: animation options
    public func oy_contentOffsetAnimate(x: CGFloat? = nil, y: CGFloat? = nil, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .curveEaseOut) {
        let xOffset = x ?? oy_contentOffsetX
        let yOffset = y ?? oy_contentOffsetY

        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.oy_contentOffset = .oy_init(xOffset, yOffset)
            }, completion: nil)
        }
    }

    /// Scroll to the most content offset by position
    /// - Parameters:
    ///   - position: scroll position: top, bottom etc.
    ///   - animated: if the should be animated (default is true)
    public func oy_scrollTo(position: Position, animated: Bool = true) {
        var point = CGPoint()

        switch position {
        case .top: point = .oy_init(contentOffset.x, -contentInset.top)
        case .bottom: point = .oy_init(contentOffset.x, max(0, contentSize.height - bounds.height) + contentInset.bottom)
        case .left: point = .oy_init(-contentInset.left, contentOffset.y)
        case .right: point = .oy_init(max(0, contentSize.width - bounds.width) + contentInset.right, contentOffset.y)
        }

        setContentOffset(point, animated: animated)
    }

    /// Observe UIScrollView's contentOffset changes
    /// - Parameter completion: completion handler with CGPoint
    public func oy_observeContentOffset(completion: ((CGPoint?) -> Void)?) {
        _ = observe(\.contentOffset, options: .new) { _, value in
            completion?(value.newValue)
        }
    }

    /// Observe UIScrollView's contentSize changes
    /// - Parameter completion: completion handler with CGSize
    public func oy_observeContentSize(closure: ((CGSize?) -> Void)?) {
        _ = observe(\.contentSize, options: .new) { _, value in
            closure?(value.newValue)
        }
    }

    /// Snapshot of type optional UIImage
    public override var oy_snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Hide keyboard when scrolling
    /// - Parameter when: KeyboardDismissMode
    /// • onDrag: dismisses the keyboard when a drag begins
    /// • interactive: the keyboard follows the dragging touch off screen, and may be pulled upward again to cancel the dismiss
    /// • onDragWithAccessory: dismisses both keyboard and accessory in the style of UIScrollViewKeyboardDismissModeOnDrag
    /// • interactiveWithAccessory: dismisses both keyboard and accessory in the style of UIScrollViewKeyboardDismissModeInteractive
    public func oy_keyboardDismiss(when: KeyboardDismissMode) {
        keyboardDismissMode = when
    }
}

extension UIScrollView {
    public enum Position {
        case top
        case bottom
        case left
        case right
    }
}
