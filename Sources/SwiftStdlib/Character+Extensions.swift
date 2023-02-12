//
//  Character+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Character {
    /// let sample: Character = "💻"
    /// `sample.oy_isEmoji`→ output → true
    public var oy_isEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
}
