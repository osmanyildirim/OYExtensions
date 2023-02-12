//
//  URL+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension URL {
    /// `try URL.oy_init(string: "https://www.apple.com")`
    public static func oy_init(string: String) throws -> Self? {
        guard let url = URL(string: string), url.oy_isValid else { throw OYError.urlIsNotValid }
        return url
    }

    /// `url.oy_isValid` → output → true
    public var oy_isValid: Bool {
        Self.oy_isValid(absoluteString)
    }

    /// `URL.oy_isValid("https://www.apple.com/mac")` → output → true
    public static func oy_isValid(_ string: String) -> Bool {
        if let url = URL(string: string) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

    /// `url.oy_nonScheme` → output → "www.apple.com/mac"
    public var oy_nonScheme: String? {
        if let scheme = scheme {
            let nonScheme = String(absoluteString.dropFirst(scheme.count + 3))
            return nonScheme
        }
        return nil
    }

    /// `url.oy_domain` → output → "https://www.apple.com"
    public var oy_domain: String? {
        guard !pathComponents.isEmpty, var nonQueryItemsUrl = self.oy_nonQueryItems else { return nil }

        for _ in 0..<pathComponents.count - 1 {
            nonQueryItemsUrl.deleteLastPathComponent()
        }
        return nonQueryItemsUrl.absoluteString
    }

    /// `url.oy_queryItems` → output → [key : "lang" value : "en"]
    public var oy_queryItems: [String: Any] {
        var items: [String: Any] = [:]
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else { return items }
        queryItems.forEach { items[$0.name] = $0.value }
        return items
    }

    /// `url.oy_nonQueryItems` → output → "https://www.apple.com"
    public var oy_nonQueryItems: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        return components.url
    }

    /// `URL(string: "https://example.com?abc=12&def=34").oy_queryItem(name: "abc")` → output → 12
    public func oy_queryItem(name: String) -> String? {
        URLComponents(string: absoluteString)?.queryItems?.first { $0.name.caseInsensitiveCompare(name) == .orderedSame }?.value
    }

    /// `URL(string: "https://example.com").oy_appendQueryItem(name: "abc", value: 12)` → output → "https://example.com?abc=12
    public func oy_appendQuery(name: String, value: Any?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return self
        }
        urlComponents.queryItems = urlComponents.queryItems?.filter { $0.name.caseInsensitiveCompare(name) != .orderedSame } ?? []

        guard let value else { return self }
        urlComponents.queryItems?.append(URLQueryItem(name: name, value: "\(value)"))

        return urlComponents.url ?? self
    }

    /// `URL(string: "https://example.com").oy_appendQuery(items: ["abc": 12])` → output → "https://example.com?abc=12
    public func oy_appendQuery(items: [String: Any?]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString), !items.isEmpty else {
            return self
        }
        let keys = items.keys.map { $0.lowercased() }

        urlComponents.queryItems = urlComponents.queryItems?.filter { !keys.contains($0.name.lowercased()) } ?? []

        urlComponents.queryItems?.append(contentsOf: items.compactMap {
            guard let value = $0.value else { return nil }
            return URLQueryItem(name: $0.key, value: "\(value)")
        })

        return urlComponents.url ?? self
    }

    /// `URL(string: "https://example.com?abc=12").oy_removeQuery(name: "abc")` → output → "https://example.com
    public func oy_removeQuery(name: String) -> URL {
        oy_appendQuery(name: name, value: nil)
    }
}

extension String {
    /// `"https://www.google.com.tr".oy_url`
    public var oy_toUrl: URL? {
        URL(string: self)
    }
}
