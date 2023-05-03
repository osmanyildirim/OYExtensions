//
//  FileManager+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension FileManager {
    /// `FileManager.oy_applicationSupportPath` → output →  .../Library/Application Support
    public static var oy_applicationSupportPath: String? {
        if #available(iOS 16.0, *) {
            return URL.applicationSupportDirectory.absoluteString
        } else {
            return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.absoluteString
        }
    }

    /// `FileManager.oy_cachesPath` → output → .../Library/Caches
    public static var oy_cachesPath: String? {
        if #available(iOS 16.0, *) {
            return URL.cachesDirectory.absoluteString
        } else {
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.absoluteString
        }
    }

    /// `FileManager.oy_documentsPath` → output → .../Documents
    public static var oy_documentsPath: String? {
        if #available(iOS 16.0, *) {
            return URL.documentsDirectory.absoluteString
        } else {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.absoluteString
        }
    }

    /// `FileManager.oy_temporaryPath` → output → .../tmp
    public static var oy_temporaryPath: String? {
        if #available(iOS 16.0, *) {
            return URL.temporaryDirectory.absoluteString
        } else {
            return "file://" + NSTemporaryDirectory()
        }
    }
    
    /// Contents in the Application Support directory
    /// `FileManager.oy_contentsOfApplicationSupport`
    public static var oy_contentsOfApplicationSupport: [String] {
        if #available(iOS 16.0, *) {
            return (try? FileManager.default.contentsOfDirectory(at: .applicationSupportDirectory, includingPropertiesForKeys: nil).map(\.path)) ?? []
        } else {
            guard let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return [] }
            return (try? FileManager.default.contentsOfDirectory(at: applicationSupport, includingPropertiesForKeys: nil).map(\.path)) ?? []
        }
    }

    /// Contents in the Caches directory
    /// `FileManager.oy_contentsOfCaches`
    static var oy_contentsOfCaches: [String] {
        if #available(iOS 16.0, *) {
            return (try? FileManager.default.contentsOfDirectory(at: .cachesDirectory, includingPropertiesForKeys: nil).map(\.path)) ?? []
        } else {
            guard let caches = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return [] }
            return (try? FileManager.default.contentsOfDirectory(at: caches, includingPropertiesForKeys: nil).map(\.path)) ?? []
        }
    }

    /// Contents in the Documents directory
    /// `FileManager.oy_contentsOfDocuments`
    static var oy_contentsOfDocuments: [String] {
        if #available(iOS 16.0, *) {
            return (try? FileManager.default.contentsOfDirectory(at: .documentsDirectory, includingPropertiesForKeys: nil).map(\.path)) ?? []
        } else {
            guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
            return (try? FileManager.default.contentsOfDirectory(at: documents, includingPropertiesForKeys: nil).map(\.path)) ?? []
        }
    }

    /// Contents in the tmp directory
    /// `FileManager.oy_contentsOfTemporary`
    static var oy_contentsOfTemporary: [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory()).map({ NSTemporaryDirectory() + $0 })) ?? []
    }

    /// `FileManager.oy_fileSize(of: imageURL.path)`→ output → 807735
    public static func oy_fileSize(of path: String) -> Int {
        let attributes = try? FileManager.default.attributesOfItem(atPath: path)
        return (attributes?[FileAttributeKey.size] as? Int) ?? 0
    }
}
