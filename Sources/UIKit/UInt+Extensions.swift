//
//  UInt+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension UInt64 {
    /// `UInt64(1).oy_megabytes` → output → 1048576
    public var oy_megabytesToByte: Self {
        UInt64(self * 1024 * 1024)
    }
}
