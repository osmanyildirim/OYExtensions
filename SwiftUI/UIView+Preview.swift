//
//  UIViewPreview.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import SwiftUI

/// Preview the UIView design on the Xcode canvas.
///
///     struct View_Preview: PreviewProvider {
///         static var previews: some View {
///             UIViewControllerPreview(FirstView())
///         }
///     }

@available(iOS 13.0, *)
public struct UIViewPreview<V: UIView>: UIViewRepresentable {
    private let view: V

    public init(_ view: V) {
        self.view = view
    }

    public func makeUIView(context: Context) -> UIView {
        return view
    }

    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
