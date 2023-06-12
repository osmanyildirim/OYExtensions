//
//  Data+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation
#if canImport(CryptoKit)
    import CryptoKit
#endif

extension Data {
    /// `data.oy_decode()`
    public func oy_decode<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }

    /// `data.oy_string()`
    public func oy_string(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }

    /// `data.oy_json()`
    public func oy_json(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        try JSONSerialization.jsonObject(with: self, options: options)
    }

    /// `data.oy_dictionary()`
    public func oy_dictionary(options: JSONSerialization.ReadingOptions = []) throws -> [String: Any]? {
        let data = try JSONSerialization.jsonObject(with: self, options: options) as? [String: Any]
        return data
    }

    /// `data.oy_bytes` → output → [100, 97, 116, 97]
    public var oy_bytes: [UInt8] {
        Array(self)
    }

    /// `data.oy_hexString` → output → "56616c7565"
    public var oy_hexString: String {
        return withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> String in
            let buffer = bytes.bindMemory(to: UInt8.self)
            return buffer.map { String(format: "%02hhx", $0) }.reduce("", { $0 + $1 })
        }
    }

    /// `imageData.oy_mimeType` → output → "image/png"
    public var oy_mimeType: String? {
        var values = [UInt8](repeating: 0, count: 1)
        copyBytes(to: &values, count: 1)

        switch values[0] {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }

    /// `imageData.oy_base64EncodedString`
    public var oy_base64EncodedString: String {
        base64EncodedString()
    }

    /// Encrypts Data with the given key using AES.GCM and returns the encrypted data
    /// `let key = SymmetricKey(size: .bits256)`
    /// `try? data?.oy_encrypt(key: key)`
    @available(iOS 13.0, *) public func oy_encrypt(key: SymmetricKey) throws -> Data? {
        try AES.GCM.seal(self, using: key).combined
    }

    /// Decrypts encrypted Data with the given key using AES.GCM and returns the decrypted Data
    /// `let key = SymmetricKey(size: .bits256)`
    /// `try? data?.oy_decrypt(key: key)`
    @available(iOS 13.0, *) public func oy_decrypt(key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: self)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

extension String {
    /// Convert base64 string to Data
    public var oy_base64EncodedData: Data? {
        Data(base64Encoded: self)
    }
}
