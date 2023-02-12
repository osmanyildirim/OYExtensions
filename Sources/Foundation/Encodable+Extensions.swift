//
//  Encodable+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Encodable {
    /// `model.oy_encodedData()`
    public func oy_encodedData(encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }

    /// `model.oy_jsonString`
    public var oy_jsonString: String? {
        guard let data = try? oy_encodedData() else {
            return nil
        }

        return try? data.oy_json() as? String
    }

    /// `model.oy_encodedDictionary`
    public var oy_encodedDictionary: [String: Any]? {
        guard let data = try? oy_encodedData() else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
    
    /// `ClassSample.oy_className`  → output →  "ClassSample"
    public static var oy_className: String {
        String(describing: self)
    }
}
