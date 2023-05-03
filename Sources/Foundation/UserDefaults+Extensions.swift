//
//  UserDefaults+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension UserDefaults {
    /// Initializer method
    /// `UserDefaults.oy_init(suite: "OYExtensions_UserDefaults")`
    public static func oy_init(suite name: String) -> UserDefaults? {
        UserDefaults(suiteName: name)
    }

    /// - Parameters:
    ///   - value: object to save.
    ///   - key: UserDefaults key
    public func oy_save<T>(_ value: T, key: String) {
        switch value {
        case is Int, is Float, is Double, is Bool, is URL, is URL?:
            set(value, forKey: key)
        default:
            if let value = value as? Codable, let data = try? value.oy_encodedData() {
                set(data, forKey: key)
            }
        }
    }

    /// - Parameters:
    ///   - type: object type to save.
    ///   - key: UserDefaults key
    /// - Returns: optional value with generic `T` type
    public func oy_value<T: Decodable>(type: T.Type, key: String) throws -> T? {
        let value = value(forKey: key)

        if let data = value as? Data {
            do {
                return try data.oy_decode()
            } catch {
                throw error
            }
        } else {
            return value as? T
        }
    }

    /// Delete objects by keys from UserDefaults.
    /// - Parameter keys: keys of objects to be remove
    public func oy_remove(keys: [String]) {
        let removeClosure = { (key: String) in
            self.removeObject(forKey: key)
        }
        keys.forEach(removeClosure)
    }

    /// Delete object from store.
    /// - Parameter suite: optional SuiteName
    /// If suiteName is null, one by one key-value is deleted
    public func oy_removeAll(suite: String?) {
        guard let suite else {
            oy_remove(keys: dictionaryRepresentation().oy_allKeys)
            return
        }
        UserDefaults.standard.removePersistentDomain(forName: suite)
    }
}
