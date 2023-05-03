//
//  OYAction.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

public struct OYAction: Equatable {
    var title: String
    var style: UIAlertAction.Style

    public init(title: String, style: UIAlertAction.Style) {
        self.title = title
        self.style = style
    }
}
