//
//  Dictionary+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Dictionary {
    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict[0]` → output → (key: "Key3", value: "Value3")
    public subscript(i: Int) -> (key: Key, value: Value)? {
        guard i >= 0 && i < values.count else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_random` → output → Value2
    public var oy_random: Value? {
        Array(values).oy_random
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `do { try dict.oy_get(index: 9, default: 10) } catch { }` → output → nil
    public func oy_get(index i: Int, `default` j: Int) throws -> (key: Key, value: Value) {
        if let value = self[i] {
            return value
        } else if let defaultValue = self[i] {
            return defaultValue
        } else {
            throw OYError.indexOutOfBounds
        }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2]
    /// `dict.oy_get("Key1")` → output  → "Value1"
    public func oy_get(_ key: Key) -> Value? {
        self[key]
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_get(key: "Key1")` → output  → ["Key1": "Value1"]
    public func oy_get(key: Key) -> [Key: Value] {
        var result = Self()
        result[key] = self[key]
        return result
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_get(keys: ["Key1", "Key2"])` → output  → ["Key1": "Value1", "Key2": "Value2"]
    public func oy_get(keys: [Key]) -> [Key: Value] {
        keys.reduce(into: [Key: Value]()) { result, item in
            result[item] = self[item]
        }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2"]
    /// `dict.oy_set(key: "Key3", value: "Value3")` → output  → ["Key1": "NewValue", "Key2": "Value2", "Key3": "Value3"]
    public mutating func oy_set(key: Key, value: Value) {
        self[key] = value
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2"]
    /// `dict.oy_update(key: "Key1", value: "NewValue")` → output  → ["Key1": "NewValue", "Key2": "Value2"]
    public mutating func oy_update(key: Key, value: Value) {
        guard keys.contains(key) else { return }
        self[key] = value
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_update(keys: ["Key1", "Key3"], value: "NewValue")` → output  → ["Key1": "NewValue", "Key2": "Value2", "Key3": "NewValue"]
    public mutating func oy_update(keys: [Key], value: Value) {
        for (k, _) in self where keys.contains(k) {
            self[k] = value
        }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2"]
    /// `dict.oy_append(["Key3": "Value3"])` → output → ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    public mutating func oy_append (_ rhs: [Key: Value]) {
        rhs.forEach { self[$0] = $1 }
    }
    
    /// var dict = ["Key1": ["Value1", "Value2"]]
    /// `dict.oy_append(key: "Key1", array: ["Value3", "Value4"])` → output → ["Key1": ["Value1", "Value2", "Value3", "Value4"]]
    /// `dict.oy_append(key: "Key2", array: ["Value5", "Value6"])` → output → ["Key1": ["Value1", "Value2"], "Key2": ["Value5", "Value6"]]
    public mutating func oy_append<T>(key: Key, array: [T]) where Value == [T] {
        self[key] == nil ? self[key] = array: self[key]?.append(contentsOf: array)
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// var dict_2 = ["Key4": "Value4", "Key5": "Value5", "Key6": "Value6"]
    /// let result = `dict + dict_2` → output → dict.count → 6
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `oy_filter { key, value in return key == "Key2" }` → output → ["Key2": "Value2"]
    public func oy_filter(_ contidion: (Key, Value) -> Bool) -> Dictionary {
        var result = Dictionary()
        for (key, value) in self where contidion(key, value) {
            result[key] = value
        }
        return result
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_contains(key: "Key2")` → output → true
    public func oy_contains(key: Key) -> Bool {
        contains { $0.0 == key }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_contains(value: "Value2")` → output → true
    public func oy_contains(value: Value) -> Bool where Value: Equatable {
        contains { $0.1 == value }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_remove(keys: ["Key1", "Key2"])` → output → ["Key3": "Value3"]
    public mutating func oy_remove(keys: Key...) {
        keys.forEach { removeValue(forKey: $0) }
    }
    
    /// var dict = ["Key1": ["Value1", "Value2"]]
    /// `dict.oy_removeValue(key: "Key1", value: "Value2")` → output → ["Key1": ["Value1"]]
    public mutating func oy_removeValue<T: Equatable>(key: Key, value: T) where Value == [T] {
        self[key]?.removeAll(where: { $0 == value })
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_removeAll()` → output → dict.count → 0
    public mutating func oy_removeAll() {
        self.keys.forEach { removeValue(forKey: $0) }
    }

    /// var dict: Dictionary<String, Any?> = ["Key1": "Value1", "Key2": "Value2", "Key3": nil]
    /// `dict.oy_clearNilValues()` → output → ["Key1": "Value1", "Key2": "Value2"]
    public mutating func oy_clearNilValues() where Value == Any? {
        let dict = self.compactMapValues { $0 }
        self = dict
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_hasValue(key: "Key3")` → output  → true
    public func oy_hasValue(key: Key) -> Bool {
        index(forKey: key) != nil
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_keys(value: "Value1")` → output  → "Key1"
    public func oy_keys(value: Value) -> Key? where Value: Equatable {
        keys.first { self[$0] == value }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_keys(values: ["Value1", "Value2"])` → output  → ["Key1", "Key2"]
    public func oy_keys(values: [Value]) -> [Key] where Value: Equatable {
        keys.filter { guard let value = self[$0] else { return false }; return values.contains(value) }
    }
    
    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_allKeys` → output  → ["Key1", "Key2", "Key3"]
    public var oy_allKeys: [Key] {
        Array(keys)
    }
    
    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_allValues` → output  → ["Value1", "Value2", "Value3"]
    public var oy_allValues: [Value] {
        values.compactMap({ $0 })
    }

    /// var dict = ["Key2": "Value2", "Key3": "Value3", "Key1": "Value1"]
    /// `dict.oy_sortByValue()` → output  → [("Key1", "Value1"), ("Key2", "Value2"), ("Key3", "Value3")]
    public func oy_sortByValue() -> [(Key, Value)] where Value: Comparable {
        Array(self).sorted { $0.1 < $1.1 }
    }

    /// var dict = ["Key2": "Value2", "Key3": "Value3", "Key1": "Value1"]
    /// `dict.oy_sortByKey()` → output  → [("Key1", "Value1"), ("Key2", "Value2"), ("Key3", "Value3")]
    public func oy_sortByKey() -> [(Key, Value)] where Key: Comparable {
        Array(self).sorted { $0.0 < $1.0 }
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.oy_swapKeyValue()` → output  → ["Value1": "Key1", "Value2": "Key2", "Value3": "Key3"]
    public func oy_swapKeyValue() -> [Value: Key] where Value: Hashable {
        var dict = [Value: Key]()
        for (key, value) in self {
            dict[value] = key
        }
        return dict
    }

    /// `Dictionary.oy_merge(keys: ["Key1", "Key2", "Key3"], values: ["Value1", "Value2", "Value3"])` → output  → ["Key3": "Value3", "Key1": "Value1", "Key2": "Value2"]
    public static func oy_merge(keys: [Key], values: [Value]) -> Self {
        Dictionary(uniqueKeysWithValues: zip(keys, values))
    }

    /// let dict = ["A_Value", "B_Value", "W_Value", "K_Value", "N_Value"]
    /// `Dictionary.oy_group(grouping: dict, by: { $0.first })` → output  → ["B": ["B_Value"], "A": ["A_Value"], "N": ["N_Value"], "W": ["W_Value"], "K": ["K_Value"]]
    public static func oy_group<S>(grouping values: S, by keyForValue: (S.Element) throws -> Key) rethrows -> Self where Value == [S.Element], S: Sequence {
        try Dictionary(grouping: values, by: keyForValue)
    }

    /// `dict.oy_data()`→ output  → (Foundation.Data?) 49 bytes
    /// `dict.oy_data(prettify: true)` → output  → (Foundation.Data?) 65 bytes
    public func oy_data(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options: JSONSerialization.WritingOptions = (prettify == true) ? .prettyPrinted : .init()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }

    /// `dict.oy_json()` → output  → "{\"Key3\":\"Value3\",\"Key1\":\"Value1\",\"Key2\":\"Value2\"}"
    public func oy_json(prettify: Bool = false) -> String? {
        guard let jsonData = oy_data(prettify: prettify) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
