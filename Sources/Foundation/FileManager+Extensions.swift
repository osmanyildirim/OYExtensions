//
//  FileManager+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension FileManager {
    /// `FileManager.oy_applicationSupportPath`
    public static var oy_applicationSupportPath: String? {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.absoluteString
    }

    /// `FileManager.oy_cachesPath`
    public static var oy_cachesPath: String? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.absoluteString
    }

    /// `FileManager.oy_documentsPath`
    public static var oy_documentsPath: String? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.absoluteString
    }

    /// `FileManager.oy_temporaryPath`
    public static var oy_temporaryPath: String? {
        "file://" + NSTemporaryDirectory()
    }
    
    /// `FileManager.oy_fileSize(of: imageURL.path)`→ output → 807735
    public static func oy_fileSize(of path: String) -> Int {
        let attributes = try? FileManager.default.attributesOfItem(atPath: path)
        return (attributes?[FileAttributeKey.size] as? Int) ?? 0
    }
}
