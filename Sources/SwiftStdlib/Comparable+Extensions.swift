//
//  Comparable+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Comparable {
    /// `1.oy_isBetween(5...7)` → output → false
    /// `7.oy_isBetween(6...12)` → output → true
    /// `date.oy_isBetween(date1...date2)` → output → false
    /// `"c".oy_isBetween(a...d)` → output → true
    /// `0.32.oy_isBetween(0.31...0.33)` → output → true
    public func oy_isBetween(_ range: ClosedRange<Self>) -> Bool {
        range ~= self
    }
    
    /// `5.oy_minValueOnRange(to: 0...1)` → output → 5
    /// `0.5.oy_minValueOnRange(to: 0...1)` → output → 0.5
    public func oy_minValueOnRange(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
