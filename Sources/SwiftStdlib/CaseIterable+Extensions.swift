//
//  CaseIterable+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension CaseIterable {
    /// Get random element of CaseIterable enum
    /// `Foo.oy_random`
    public static var oy_random: Self? {
        var generator = SystemRandomNumberGenerator()
        return randomCaseIterableElement(using: &generator)
    }
}

extension CaseIterable {
    private static func randomCaseIterableElement(using generator: inout some RandomNumberGenerator) -> Self? {
        allCases.randomElement(using: &generator)
    }
}
