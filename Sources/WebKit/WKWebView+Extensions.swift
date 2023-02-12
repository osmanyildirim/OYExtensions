//
//  WKWebView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import WebKit

extension WKWebView {
    /// Clear all website data like cookies, local storage, caches, etc.
    /// `await WKWebView().oy_clear()`
    @available(iOS 13.0.0, *)
    func oy_clearData() async {
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)

        let store = WKWebsiteDataStore.default()
        let dataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let records = await store.dataRecords(ofTypes: dataTypes)
        await store.removeData(ofTypes: dataTypes, for: records)
    }

    /// Navigate to URL
    /// - Parameters:
    ///   - url: URL to navigate
    ///   - timeout: timeout interval
    /// - Returns: optional WKNavigation
    @discardableResult public func oy_load(url: URL?, timeout: TimeInterval? = nil) throws -> WKNavigation? {
        guard let url else {
            throw OYError.urlIsNotValid
        }

        var request = URLRequest(url: url)

        if let timeout {
            request.timeoutInterval = timeout
        }
        return load(request)
    }

    /// Navigate to URL String
    /// - Parameters:
    ///   - url: URL String to navigate
    ///   - timeout: timeout interval
    /// - Returns: optional WKNavigation
    @discardableResult public func oy_load(urlString: String, timeout: TimeInterval? = nil)throws -> WKNavigation? {
        try oy_load(url: URL(string: urlString))
    }
}
