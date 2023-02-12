//
//  UIStackView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIStackView: OYInit {
    public typealias ViewType = UIStackView

    /// Initializer method with `distribution,alignment,axis and spacing` values
    public static func oy_init(distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView: UIStackView = oy_init()
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.axis = axis
        stackView.spacing = spacing

        return stackView
    }

    /// Adds views to UIStackView
    public func oy_add(arrangedSubviews: UIView...) {
        _ = arrangedSubviews.map({ addArrangedSubview($0) })
    }

    /// Adds array of views to UIStackView
    public func oy_add(arrangedSubviews: [UIView]) {
        _ = arrangedSubviews.map({ addArrangedSubview($0) })
    }

    /// Removes all aranged views in UIStackView
    public func oy_removeArrangedSubviews() {
        _ = arrangedSubviews.map({ removeArrangedSubview($0) })
    }
}
