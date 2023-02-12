//
//  Decodable+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Decodable {
    /// `ClassSample.oy_className`  → output →  "ClassSample"
    public static var oy_className: String {
        String(describing: self)
    }
}
