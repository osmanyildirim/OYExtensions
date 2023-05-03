//
//  Int+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Int {
    /// let value: Int = 3
    /// `value.oy_string` → output → (String) "3"
    public var oy_string: String {
        return String(self)
    }

    /// let value: Int = 3
    /// `value.oy_float` → output → (CGFloat) 3.0
    public var oy_cgFloat: CGFloat {
        return CGFloat(self)
    }

    /// let value: Int = 3
    /// `value.oy_string` → output → (Double) 3.0
    public var oy_double: Double {
        return Double(self)
    }

    /// let value: Int = 3
    /// `value.oy_float` → output → (Float) 3.0
    public var oy_float: Float {
        return Float(self)
    }

    /// let value: Int = 314
    /// `value.oy_digits` → output → [3, 1, 4]
    public var oy_digits: [Int] {
        guard self != 0 else { return [0] }
        var digits = [Int]()
        var number = abs(self)

        while number != 0 {
            let digit = number % 10
            digits.append(digit)
            number /= 10
        }

        digits.reverse()
        return digits
    }

    /// let value: Int = 314
    /// `value.oy_digitsCount` → output → 3
    public var oy_digitsCount: Int {
        guard self != 0 else { return 1 }
        let number = Double(abs(self))
        return Int(log10(number) + 1)
    }
    
    /// let value: Int = 2
    /// `value.oy_isEven` → output → true
    public var oy_isEven: Bool {
        self % 2 == 0
    }
    
    /// let value: Int = 2
    /// `value.oy_isOdd` → output → false
    public var oy_isOdd: Bool {
        !oy_isEven
    }

    /// `0.oy_format` → output → "0"
    /// `100.oy_format` → output → "100"
    /// `-20000.oy_format` → output → -2K
    /// `1000000.oy_format` → output → 1M
    /// `-2000000000.oy_format` → output → -2B
    public var oy_format: String {
        let abs = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch abs {
        case 100_000_000_000...:
            var formattedDouble = abs / 1_000_000_000
            formattedDouble = FormatHelper.reduceScale(double: formattedDouble, places: 1)
            let formatted = Int(formattedDouble)
            return "\(sign)\(formatted)B"
        case 1_000_000_000...:
            var formattedDouble = abs / 1_000_000_000
            formattedDouble = FormatHelper.reduceScale(double: formattedDouble, places: 1)
            let noDecimal = (floor(formattedDouble) == formattedDouble)
            if noDecimal {
                let formatted = Int(formattedDouble)
                return "\(sign)\(formatted)B"
            } else {
                return "\(sign)\(formattedDouble)B"
            }
        case 100_000_000...:
            var formattedDouble = abs / 1_000_000
            formattedDouble = FormatHelper.reduceScale(double: formattedDouble, places: 1)
            let formatted = Int(formattedDouble)
            return "\(sign)\(formatted)M"
        case 1_000_000...:
            var formattedDouble = abs / 1_000_000
            formattedDouble = FormatHelper.reduceScale(double: formattedDouble, places: 1)
            let noDecimal = (floor(formattedDouble) == formattedDouble)
            if noDecimal {
                let formatted = Int(formattedDouble)
                return "\(sign)\(formatted)M"
            } else {
                return "\(sign)\(formattedDouble)M"
            }
        case 100_000...:
            var formattedDouble = abs / 1_000
            formattedDouble = FormatHelper.reduceScale(double: formattedDouble, places: 1)
            let formatted = Int(formattedDouble)
            return "\(sign)\(formatted)K"
        case 1_000...:
            var formattedDouble = abs / 1_000
            formattedDouble = FormatHelper.reduceScale(double: formattedDouble, places: 1)
            let noDecimal = (floor(formattedDouble) == formattedDouble)
            if noDecimal {
                let formatted = Int(formattedDouble)
                return "\(sign)\(formatted)K"
            } else {
                return "\(sign)\(formattedDouble)K"
            }
        case 0...:
            let formattedNumber = FormatHelper.decimalFormatter.string(from: NSNumber(value: self)) ?? ""
            return "\(formattedNumber)"
        default:
            let formattedNumber = FormatHelper.decimalFormatter.string(from: NSNumber(value: self)) ?? ""
            return "\(sign)\(formattedNumber)"
        }
    }
    
    /// `5.oy_times { time in
    /// `    print(time) // 1, 2, 3, 4, 5
    /// `}
    public func oy_times(_ completion: (Int) throws -> Void) rethrows {
        guard self > 0 else { return }
        for i in 1 ... self { try completion(i) }
    }
}

extension Int {
    private struct FormatHelper {
        static let decimalFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }()

        static func reduceScale(double: Double, places: Double) -> Double {
            let multiplier = pow(10, places)
            let truncated = Double(multiplier * double)
            return truncated / multiplier
        }
    }
}
