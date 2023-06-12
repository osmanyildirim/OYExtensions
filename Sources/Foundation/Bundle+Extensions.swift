//
//  Bundle+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Bundle {
    /// `Bundle.main.oy_langugage`→ output → "en"
    public var oy_langugage: String? {
        UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first
    }
    
    /// `Bundle.main.oy_appName`→ output → "OYExtensions"
    public var oy_appName: String? { oy_infoPlistValue(key: "CFBundleName") as? String }
    
    /// `Bundle.main.oy_targetName`→ output → "OYExtensionsStage"
    public var oy_targetName: String? { oy_infoPlistValue(key: "TargetName") as? String }
    
    /// `Bundle.main.oy_displayName`→ output → "OYExtensions"
    public var oy_displayName: String? { oy_infoPlistValue(key: "CFBundleDisplayName") as? String }

    /// `Bundle.main.oy_appVersionNumber`→ output → "1.0"
    public var oy_appVersionNumber: String? { oy_infoPlistValue(key: "CFBundleShortVersionString") as? String }
    
    /// `Bundle.main.oy_appStoreVersion(bundleId: "com.oy.extensions") { value in
    ///     value → "1.0.6"
    /// `}
    public func oy_appStoreVersion(bundleId: String, completion: @escaping ((String?) -> Void)) {
        guard let url = URL(string: "http://itunes.apple.com/in/lookup?bundleId=\(bundleId)") else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
            guard let data = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }
            guard let lookupResults = try? data.oy_dictionary() else {
                completion(nil)
                return
            }
            guard let resultCount = lookupResults["resultCount"] as? Int, resultCount == 1 else {
                completion(nil)
                return
            }
            guard let results = lookupResults["results"] as? [[String: Any]] else {
                completion(nil)
                return
            }
            guard let version = results[0]["version"] as? String else {
                completion(nil)
                return
            }

            completion(version)
        }
        task.resume()
    }

    /// `Bundle.main.oy_appBuildNumber`→ output → "1"
    public var oy_appBuildNumber: String? { oy_infoPlistValue(key: "CFBundleVersion") as? String }

    /// `Bundle.main.oy_bundleIdentifier`→ output → "com.osmanyildirim.oyExtensions"
    public var oy_bundleIdentifier: String? { oy_infoPlistValue(key: "CFBundleIdentifier") as? String }

    /// `Bundle.main.oy_isRunningOnSimulator`→ output → true
    public var oy_isRunningOnSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    /// `Bundle.main.oy_isRunningInAppStore`→ output → true
    public var oy_isRunningInAppStore: Bool {
        !oy_isRunningOnSimulator && !oy_isInTestFlight && !oy_isAdHocDistributed
    }

    /// `Bundle.main.oy_isInTestFlight`→ output → true
    public var oy_isInTestFlight: Bool {
        !oy_isRunningOnSimulator && appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" && !oy_isAdHocDistributed
    }

    /// `Bundle.main.oy_isAdHocDistributed`→ output → true
    public var oy_isAdHocDistributed: Bool {
        path(forResource: "embedded", ofType: "mobileprovision") != nil
    }

    /// `Bundle.main.oy_isExtension`→ output → true
    public var oy_isExtension: Bool {
        if bundlePath.hasSuffix(".appex") { return true }
        guard let applicationClassName = NSClassFromString("UIApplication") else { return true }
        return !applicationClassName.responds(to: Selector(("shared")))
    }

    /// `Bundle.main.oy_infoPlist(type: [String: Any].self)`
    public func oy_infoPlist<T>(type: T.Type = [String: Any].self) -> T? {
        oy_read(file: "Info", fileType: "plist", type: type)
    }

    /// `Bundle.main.oy_infoPlistValue(key: "SecretKey")`
    public func oy_infoPlistValue(key: String) -> Any? {
        object(forInfoDictionaryKey: key)
    }

    /// `Bundle.main.oy_decode(file: "sample", fileType: "json", type: Model.self)`
    public func oy_decode<T: Codable>(file: String, fileType: String, type: T.Type) -> T? {
        guard let data = oy_data(file, fileType: fileType) else { return nil }
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return decoded
    }

    /// `Bundle.main.oy.read(resource: "Info", fileType: "plist", type: Model.self)`
    public func oy_read<T>(file: String, fileType: String? = nil, type: T.Type) -> T? {
        guard let data = oy_data(file, fileType: fileType) else { return nil }
        guard let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? T else { return nil }
        return result
    }

    /// `Bundle.main.oy_write(resource: "Sample", fileType: "plist", value: newInstance)`
    public func oy_write<T: Encodable>(file: String, fileType: String? = nil, value: T) {
        guard let url = oy_path(file, fileType: fileType) else { return }
        oy_write(url, value)
    }
}

extension Bundle {
    private func oy_path(_ resource: String, fileType: String? = nil) -> URL? {
        return url(forResource: resource, withExtension: fileType)
    }

    private func oy_data(_ resource: String, fileType: String?) -> Data? {
        guard let url = oy_path(resource, fileType: fileType) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }

    private func oy_write<T>(_ url: URL, _ value: T) where T: Encodable {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        do {
            let data = try encoder.encode(value)
            try data.write(to: url)
        } catch { }
    }
}
