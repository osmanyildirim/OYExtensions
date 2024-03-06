//
//  UIViewControllerPreview.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import SwiftUI

/// Preview the UIViewController design on the Xcode canvas.
///
///     struct ViewController_Preview: PreviewProvider {
///         static var previews: some View {
///             UIViewControllerPreview(FirstViewController())
///         }
///     }

@available(iOS 13.0, *)
public struct UIViewControllerPreview<V: UIViewController>: UIViewControllerRepresentable {
    private let viewController: V

    public init(_ viewController: V) {
        self.viewController = viewController
    }

    public func makeUIViewController(context: Context) -> V {
        viewController
    }

    public func updateUIViewController(_ uiViewController: V, context: Context) { }
}
