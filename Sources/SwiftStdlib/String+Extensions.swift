//
//  String+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit
import CryptoKit

extension String {
    /// `"Hello World"[6]` → output → (String) "W"
    public subscript(at: Int) -> String {
        String(self[index(startIndex, offsetBy: at)])
    }

    /// `"Hello World"[1..<3]` → output → (String) "el"
    public subscript(at: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: at.lowerBound)
        let end = index(startIndex, offsetBy: at.upperBound)
        return String(self[start ..< end])
    }

    /// `"Hello World"[1...3]` → output → (String) "ell"
    public subscript(r: CountableClosedRange<Int>) -> String {
        let startIndex = index(startIndex, offsetBy: r.lowerBound)
        let endIndex = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }

    /// `"Hello World".oy_at(index: 6)` → output → (String) "W"
    public func oy_at(index: Int) -> String {
        self[index]
    }

    /// `"Hello World".oy_at(range: 1..<3)` → output → (String) "el"
    public func oy_at(range: Range<Int>) -> String {
        self[range]
    }

    /// `"Hello World".oy_at(range: 1...3)` → output → (String) "ell"
    public func oy_at(range: CountableClosedRange<Int>) -> String {
        self[range]
    }

    /// `"Hello World".oy_character(at: 6)` → output → (Character) "W"
    public func oy_character(at: Int) -> Character {
        self[index(startIndex, offsetBy: at)]
    }

    /// `"Hello World".oy_replace(of: "W", with: "11")` → output → "Hello 11orld"
    public func oy_replace(of: String, with: String) -> String {
        replacingOccurrences(of: of, with: with)
    }

    /// var value = "Hello World"
    /// `value.oy_replacing(of: "W", with: "11")` → output → "Hello 11orld"
    public mutating func oy_replaced(of: String, with: String) {
        self = oy_replace(of: of, with: with)
    }

    /// `"Hello World. I am a iOS Developer.".oy_replace(ofs: ["World", "iOS"], with: "Test")` → output → "Hello Test. I am a Test Developer."
    public func oy_replace(ofs: [String], with: String) -> String {
        var string = self
        for item in ofs {
            string = string.replacingOccurrences(of: item, with: with)
        }
        return string
    }

    /// var value = "Hello World. I am a iOS Developer."
    /// `value.oy_replacing(ofs: ["World", "iOS"], with: "Test")` → output → "Hello Test. I am a Test Developer."
    public mutating func oy_replaced(ofs: [String], with: String) {
        self = oy_replace(ofs: ofs, with: with)
    }

    /// `"Hello World".oy_remove(string: "World")` → output →  "Hello "
    public func oy_remove(string: String) -> String {
        return oy_replace(of: string, with: "")
    }

    /// var value = "Hello World"
    /// `value.oy_removed(string: "World")` → output → "Hello "
    public mutating func oy_removed(string: String) {
        self = oy_remove(string: string)
    }

    /// `"Hello World".oy_removeFirst(count: 2)` → output → "llo World"
    public func oy_removeFirst(count: Int) -> String {
        String(suffix(self.count - count))
    }

    /// var value = "Hello World"
    /// `value.oy_removedFirst(count: 2)` → output → "llo World"
    public mutating func oy_removedFirst(count: Int) {
        self = oy_removeFirst(count: count)
    }

    /// `"Hello World".oy_removeLast(count: 2)` → output → "Hello Wor"
    public func oy_removeLast(count: Int) -> String {
        String(prefix(self.count - count))
    }

    /// var value = "Hello World"
    /// `value.oy_removedLast(count: 2)` → output → "Hello Wor"
    public mutating func oy_removedLast(count: Int) {
        self = oy_removeLast(count: count)
    }

    /// var value = "Hello"
    /// `value.oy_removeAt(index: 0)` → output → "ello"
    public func oy_removeAt(index: Int) -> String {
        var value = self
        if let index = self.index(startIndex, offsetBy: index, limitedBy: endIndex) {
            value.remove(at: index)
        }
        return value
    }

    /// var value = "Hello"
    /// `value.oy_removedAt(index: 0)` → output → "ello"
    public mutating func oy_removedAt(index: Int) {
        self = oy_removeAt(index: index)
    }

    /// `"Lorem Ipsum is simply dummyText".oy_removeWith(left: "simply")` → output → " dummyText"
    public func oy_removeWith(left string: String) -> String {
        if let prefixRange = range(of: string) {
            if prefixRange.upperBound >= endIndex {
                return String(self[startIndex..<prefixRange.lowerBound])
            } else {
                return String(self[prefixRange.upperBound..<endIndex])
            }
        }
        return self
    }

    /// `"Lorem Ipsum is simply dummyText".oy_removeWith(right: "simply")` → output → "Lorem Ipsum is "
    public func oy_removeWith(right string: String) -> String {
        if let suffixRange = range(of: string, options: .backwards) {
            return String(self[startIndex..<suffixRange.lowerBound])
        }
        return self
    }

    /// `"Hello World".oy_substring(startIndex: 3, length: 2)` → output → "lo"
    public func oy_substring(startIndex: Int, length: Int) -> String {
        let start = index(self.startIndex, offsetBy: startIndex)
        let end = index(self.startIndex, offsetBy: startIndex + length)
        return String(self[start..<end])
    }

    /// `"Hello World".oy_split("W")` → output → ["Hello ", "orld"]
    public func oy_split(_ value: String) -> [String] {
        components(separatedBy: value)
    }

    /// `"Abc123Xyz".oy_between(left: "Abc", right: "Xyz")` → output → "123"
    public func oy_between(left: String, right: String) -> String? {
        guard let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards),
            left != right && leftRange.upperBound != rightRange.lowerBound
            else { return nil }

        return String(self[leftRange.upperBound...index(before: rightRange.lowerBound)])
    }

    /// `"Hello World".oy_indexOf("World")` → output → 6
    /// `"Hello World".oy_indexOf("o")` → output → 4
    public func oy_indexOf(_ string: String) -> Int? {
        if let range = range(of: string) {
            return distance(from: startIndex, to: range.lowerBound)
        }
        return nil
    }

    /// `"Hello World".oy_prefix(2)` → output → "He"
    public func oy_prefix(_ count: Int) -> String {
        String(prefix(count))
    }

    /// `"Hello World".oy_suffix(2)` → output → "ld"
    public func oy_suffix(_ count: Int) -> String {
        String(suffix(count))
    }

    /// `" Hello World ".oy_trimmed` → output → "Hello World"
    public var oy_trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// `"123 456 789".oy_clearSpaces` → output → "123456789"
    public var oy_clearSpaces: String {
        oy_replace(of: " ", with: "")
    }

    /// `"12345".oy_isNumber` → output → true
    /// `"12345a".oy_isNumber` → output → false
    public var oy_isNumber: Bool {
        range(of: "^[0-9]*$", options: .regularExpression) != nil
    }

    /// `"sample@gmail.com".oy_isValidEmail` → output → true
    public var oy_isValidEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }

    /// `"https://www.google.com.tr".oy_isValidUrl` → output → true
    public var oy_isValidUrl: Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }

    /// `"Hello World Hello".oy_wordCount("Hello")` → output → 2
    /// `"Hello World Hello".oy_wordCount("o")` → output → 3
    public func oy_wordCount(_ substring: String) -> Int {
        components(separatedBy: substring).count - 1
    }

    /// `"Hello \n World.\n\n\t  I am a \niOS Developer.".oy_removeMoreSpaces()`  → output → "Hello World. I am a iOS Developer."
    public func oy_removeMoreSpaces() -> String {
        let components = components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        return components.joined(separator: " ")
    }

    /// `"Hello World".oy_isEndsWith("World")` → output → true
    public func oy_isEndsWith(_ suffix: String) -> Bool {
        hasSuffix(suffix)
    }

    /// `"Hello World".oy_isStartsWith("Hello")` → output → true
    public func oy_isStartsWith(_ suffix: String) -> Bool {
        hasSuffix(suffix)
    }

    /// `"Hello World".oy_initials` → output → "HW"
    public var oy_initials: String {
        let components = components(separatedBy: " ")
        return components.reduce("") { $0 + $1[startIndex...startIndex] }
    }

    /// `"ABCDE".oy_data` → output → (Foundation.Data?) $R0 = 5 bytes
    public var oy_data: Data? {
        data(using: .utf8)
    }

    /// `"ABCDE".oy_base64` → output → "QUJDREU="
    public var oy_base64: String {
        Data(utf8).base64EncodedString()
    }

    /// `"QUJDREU=".oy_fromBase64` → output → "ABCDE"
    public var oy_fromBase64: String? {
        guard let data = oy_base64EncodedData else { return nil }
        return String(data: data, encoding: .utf8)
    }

    /// `"ABCDE".oy_hex` → output → "703710"
    public var oy_hex: Int? {
        Int(self, radix: 16)
    }

    /// `"app_title".oy_localized`
    public var oy_localized: String {
        NSLocalizedString(self, comment: "")
    }

    /// `"<p><span style="color: #ad2131;">Sample</span></p>".oy_htmlToAttributedString`
    public var oy_htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }

    /// `"hello world".oy_upperFirst` → output → "Hello world"
    public var oy_upperFirst: String {
        prefix(1).uppercased() + dropFirst()
    }

    /// var value = "Hello World"
    /// `value.oy_upperedFirst()` → output → "Hello world"
    public mutating func oy_upperedFirst() {
        self = oy_upperFirst
    }

    /// `"Hello World".oy_lowerFirst` → output → "hello World"
    public var oy_lowerFirst: String {
        prefix(1).lowercased() + dropFirst()
    }

    /// var value = "Hello World"
    /// `value.oy_loweredFirst()` → output → "hello World"
    public mutating func oy_loweredFirst() {
        self = oy_lowerFirst
    }

    /// `"1".oy_int` → output → 1
    public var oy_int: Int? {
        if let number = NumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }

    /// `"A".oy_int(default: 2)` → output → 2
    public func oy_int(`default`: Int) -> Int {
        if let number = NumberFormatter().number(from: self) {
            return number.intValue
        }
        return `default`
    }

    /// `"1".oy_float` → output → 1.0
    public var oy_float: Float? {
        if let number = NumberFormatter().number(from: self) {
            return number.floatValue
        }
        return Float(self)
    }

    /// `"false".oy_Bool` → output → false
    /// `"A".oy_Bool` → output → nil
    /// `"1".oy_Bool` → output → true
    public var oy_Bool: Bool? {
        let trimmed = oy_trimmed.lowercased()
        guard Int(trimmed) != nil || Bool(trimmed) != nil else { return nil }

        switch trimmed {
        case "true", "yes", "1": return true
        case "false", "no", "0": return false
        default: return false
        }
    }

    /// `"hello wORLD".oy_titleCase` → output → "Hello World"
    public var oy_titleCase: String {
        capitalized
    }

    /// `"HELLO WORLD".oy_lowercase` → output → "hello world"
    public var oy_lowercase: String {
        lowercased()
    }

    /// `"hello wORLD".oy_uppercase` → output → "HELLO WORLD"
    public var oy_uppercase: String {
        uppercased()
    }

    /// `"HelloWorld".oy_snakeCase` → output → "hello_world"
    public var oy_snakeCase: String {
        let pattern = "([a-z0-9])([A-Z])"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? ""
    }

    /// `"IOS".oy_spaceToHead` → output → " IOS"
    public var oy_spaceToHead: String {
        " " + self
    }

    /// var value = "IOS"
    /// `value.oy_spacedToHead()` → output → " IOS"
    public mutating func oy_spacedToHead() {
        self = oy_spaceToHead
    }

    /// var value = "IOS"
    /// `value.oy_spaceToHead(3)` → output → "   IOS"
    public func oy_spaceToHead(_ count: Int) -> String {
        var string = ""
        for _ in 0 ..< count {
            string += " "
        }
        return string + self
    }

    /// var value = "IOS"
    /// `value.oy_spacedToHead(3)` → output → "   IOS"
    public mutating func oy_spacedToHead(_ count: Int) {
        self = oy_spaceToHead(count)
    }

    /// `"IOS".oy_spaceToEnd` → output → "IOS "
    public var oy_spaceToEnd: String {
        self + " "
    }

    /// var value = "IOS"
    /// `value.oy_spacedToEnd()` → output → "IOS "
    public mutating func oy_spacedToEnd() {
        self += " "
    }

    /// `"IOS".oy_spaceToHeadAndEnd` → output → " IOS "
    public var oy_spaceToHeadAndEnd: String {
        " " + self + " "
    }

    /// var value = "IOS"
    /// `value.oy_spacedToHeadAndEnd()` → output → " IOS "
    public mutating func oy_spacedToHeadAndEnd() {
        self = oy_spaceToHeadAndEnd
    }

    /// `"IOS".oy_newLineToHead` → output → "\nIOS"
    public var oy_newLineToHead: String {
        "\n" + self
    }

    /// var value = "IOS"
    /// `value.oy_newLinedToHead()` → output → "\nIOS"
    public mutating func oy_newLinedToHead() {
        self = oy_newLineToHead
    }

    /// `"IOS".oy_newLineToEnd` → output → "IOS\n"
    public var oy_newLineToEnd: String {
        self + "\n"
    }

    /// var value = "IOS"
    /// `value.oy_newLinedToEnd()` → output → "IOS\n"
    public mutating func oy_newLinedToEnd() {
        self = oy_newLineToEnd
    }

    /// `"IOS".oy_newLineToHeadAndEnd` → output → "\nIOS\n"
    public var oy_newLineToHeadAndEnd: String {
        "\n" + self + "\n"
    }

    /// var value = "IOS"
    /// `value.oy_newLinedToHeadAndEnd()` → output →  "\nIOS\n"
    public mutating func oy_newLinedToHeadAndEnd() {
        self = oy_newLineToHeadAndEnd
    }

    /// `"IOS".oy_addPoint` → output → " IOS."
    public var oy_addPoint: String {
        self + "."
    }

    /// var value = "IOS"
    /// `value.oy_addedPoint()` → output → " IOS."
    public mutating func oy_addedPoint() {
        self = oy_addPoint
    }

    /// `"IOS".oy_addComma` → output → " IOS,"
    public var oy_addComma: String {
        self + ","
    }

    /// var value = "IOS"
    /// `value.oy_addedComma()` → output → " IOS,"
    public mutating func oy_addedComma() {
        self = oy_addComma
    }

    /// `"50".oy_addPercent` → output → " % 50"
    public var oy_addPercent: String {
        "% " + self
    }

    /// var value = "IOS"
    /// `value.oy_addedPercent()` → output →  " % 50"
    public mutating func oy_addedPercent() {
        self = oy_addPercent
    }

    /// `"123abc".oy_hasLetter` → output → true
    public var oy_hasLetter: Bool {
        rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// `"123abc".oy_hasNumber` → output → true
    public var oy_hasNumber: Bool {
        rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }

    /// `"abc".oy_isAlphabetic` → output → true
    /// `"123abc".oy_isAlphabetic` → output → false
    public var oy_isAlphabetic: Bool {
        let lettrs = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let numbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return lettrs && !numbers
    }

    /// `"123abc".oy_isAlphaNumeric` → output → true
    /// `"abc".oy_isAlphaNumeric` → output → false
    public var oy_isAlphaNumeric: Bool {
        let letters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let numbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let components = components(separatedBy: .alphanumerics)
        return components.joined(separator: "").count == 0 && letters && numbers
    }

    /// `"1.0.2".oy_isOldVersion(comparedWith: "1.1")`  → output → true
    public func oy_isOldVersion(comparedWith version: String) -> Bool {
        compare(version, options: .numeric) == .orderedAscending
    }

    /// `"github.com lorem ipsum twitter.com".oy_detectUrls()`  → output → [http://github.com, http://twitter.com] }
    public func oy_detectUrls() -> [URL]? {
        let urlDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = urlDetector?.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        return matches?.compactMap({ $0.url })
    }

    /// `"💻".oy_isEmoji`→ output → true
    /// `"💻📱".oy_isEmoji`→ output → false
    public var oy_isEmoji: Bool {
        count == 1 && (first?.oy_isEmoji ?? false)
    }

    /// `"💻📱".oy_isAllSatisfyEmoji` → output → true
    /// /// `"💻A".oy_isAllSatisfyEmoji`→ output → false
    public var oy_isAllSatisfyEmoji: Bool {
        allSatisfy({ $0.oy_isEmoji })
    }

    /// Encrypts plain String with the given key using AES.GCM and returns a base64 encoded encrypted data
    /// `let key = SymmetricKey(size: .bits256)`
    /// `try? "Hello World".encrypted(key: SymmetricKey(size: .bits256))` → output → "aDhmrk8N8i6Bmi9jYycRTm+V46B4LKPe8EAOYR/FUEKrLpKYBmQa"
    @available(iOS 13.0, *) public func oy_encrypt(key: SymmetricKey) throws -> String? {
        guard let data = oy_data else {
            throw OYError.stringToDataFailed
        }

        let encryptedData = try data.oy_encrypt(key: key)
        return encryptedData?.oy_base64EncodedString
    }

    /// Decrypts base64 encoded representation of encrypted data with the given key using AES.GCM and returns the decrypted plain text String
    /// `let key = SymmetricKey(size: .bits256)`
    /// `try? "aDhmrk8N8i6Bmi9jYycRTm+V46B4LKPe8EAOYR/FUEKrLpKYBmQa".oy_decrypt(key: key)` → output → "Hello World"
    @available(iOS 13.0, *) public func oy_decrypt(key: SymmetricKey) throws -> String {
        guard let encryptedData = Data(base64Encoded: self) else {
            throw OYError.decryptingDataFailed
        }

        let plainData = try encryptedData.oy_decrypt(key: key)
        guard let string = plainData.oy_string() else {
            throw OYError.dataToStringFailed
        }
        return string
    }
}
