//
//  UIApplication+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit
#if canImport(AppTrackingTransparency)
    import AppTrackingTransparency
#endif
#if canImport(SystemConfiguration)
    import SystemConfiguration
#endif
#if canImport(SafariServices)
    import SafariServices
#endif

extension UIApplication {
    /// `UIApplication.oy_badgeCount` → output → 2
    public static var oy_badgeCount: Int {
        UIApplication.shared.applicationIconBadgeNumber
    }
    
    /// Request user tracking authorization with a completion handler returning the user's authorization status.
    /// To use requestTrackingAuthorization(completionHandler:), the `NSUserTrackingUsageDescription` key must be in the Information Property List
    ///
    ///     UIApplication.oy_requestATT { result in
    ///        // do stuff
    ///     }
    @available(iOS 14, *) public static func oy_requestATT(completion: @escaping (_ result: OYATTResult) -> Void) {
        guard Bundle.main.oy_infoPlistValue(key: "NSUserTrackingUsageDescription") != nil else {
            return completion(.userTrackingUsageDescriptionNotDeclared)
        }

        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                completion(.authorized)
            case .denied:
                completion(.denied)
            case .notDetermined:
                completion(.notDetermined)
            case .restricted:
                completion(.restricted)
            @unknown default:
                completion(.denied)
            }
        }
    }
    
    /// Information the application is authorized to user tracking
    /// `UIApplication.oy_isAuthorizedATT` → output → true
    @available(iOS 14, *) public static var oy_isAuthorizedATT: Bool {
        ATTrackingManager.trackingAuthorizationStatus == .authorized
    }

    /// `UIApplication.oy_canOpen(url: "http://www.apple.com")` → output → true
    public static func oy_canOpen(url: URL) -> Bool {
        UIApplication.shared.canOpenURL(url)
    }

    /// `UIApplication.oy_open(urls: "http://www.apple.com")`
    public static func oy_open(urls: URL...) throws {
        let application = UIApplication.shared
        for url in urls {
            if oy_canOpen(url: url) {
                if #available(iOS 10.0, *) {
                    application.open(url, options: [:], completionHandler: nil)
                } else {
                    application.openURL(url)
                }
                return
            } else {
                throw OYError.urlIsNotValid
            }
        }
    }

    /// `UIApplication.oy_openAppSettings()`
    public static func oy_openAppSettings() {
        let application = UIApplication.shared

        if let url = URL(string: UIApplication.openSettingsURLString), application.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                application.open(url, options: [:], completionHandler: nil)
            } else {
                application.openURL(url)
            }
        }
    }

    /// `UIApplication.oy_callPhone(number: "12159649250")`
    public static func oy_callPhone(number: String) throws {
        let application = UIApplication.shared

        if let url = URL(string: "tel://" + number) {
            if #available(iOS 10.0, *) {
                application.open(url, options: [:], completionHandler: nil)
            } else {
                application.openURL(url)
            }
        } else {
            throw OYError.phoneNumberIsNotValid
        }
    }

    /// `UIApplication.oy_awakeScreen`
    public static func oy_awakeScreen() {
        shared.isIdleTimerDisabled = true
    }

    /// `UIApplication.oy_appIcon`
    public static var oy_appIcon: UIImage? {
        guard let icons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let icon = iconFiles.last
            else { return nil }
        return UIImage(named: icon)
    }

    /// `UIApplication.oy_isDebuggingMode` → output → true
    public static var oy_isDebuggingMode: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    /// `UIApplication.oy_isTestFlightMode` → output → false
    public static var oy_isTestFlightMode: Bool {
        Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }

    /// `UIApplication.oy_isRegisterRemoteNotifications` → output → false
    public static var oy_isRegisterRemoteNotifications: Bool {
        UIApplication.shared.isRegisteredForRemoteNotifications
    }

    /// `UIApplication.oy_keyWindow` → output → <UIWindowLayer: 0x6000002dc630>
    public static var oy_keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
                                                       .first(where: { $0 is UIWindowScene })
                                                       .flatMap({ $0 as? UIWindowScene })?.windows
                                                       .first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    /// `UIApplication.oy_statusBarHeight` → output → 54.0
    public static var oy_statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return oy_keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    /// `UIApplication.oy_isStatusBarHidden` → output → false
    public static var oy_isStatusBarHidden: Bool {
        if #available(iOS 13.0, *) {
            return oy_keyWindow?.windowScene?.statusBarManager?.isStatusBarHidden ?? false
        } else {
            return UIApplication.shared.isStatusBarHidden
        }
    }

    /// `UIApplication.oy_statusBarStyle` → output → .darkContent
    public static var oy_statusBarStyle: UIStatusBarStyle? {
        if #available(iOS 13.0, *) {
            return oy_keyWindow?.windowScene?.statusBarManager?.statusBarStyle
        } else {
            return UIApplication.shared.statusBarStyle
        }
    }

    /// `UIApplication.oy_topViewController` → output → <UINavigationController: 0x13f81f600>
    public static var oy_topViewController: UIViewController? {
        get { oy_topViewController() }
        set(value) { oy_keyWindow?.rootViewController = value }
    }
    
    /// `UIApplication.oy_topViewController()` → output → <UINavigationController: 0x13f81f600>
    private static func oy_topViewController(base: UIViewController? = UIViewController.oy_root) -> UIViewController? {
        var topViewController: UIViewController?

        if base == nil {
            return oy_topViewController(base: UIViewController.oy_root)
        }
        
        if let navigationController = base as? UINavigationController {
            topViewController = oy_topViewController(base: navigationController.visibleViewController)
        } else if let tabBarController = base as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            topViewController = oy_topViewController(base: selectedViewController)
        } else {
            return base?.presentedViewController ?? base
        }
        return topViewController
    }

    /// `UIApplication.oy_observeScreenShot { }`
    public static func oy_observeScreenShot(_ closure: @escaping () -> Void) {
        _ = NotificationCenter.default.addObserver(forName: userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
            closure()
        }
    }

    /// `UIApplication.oy_observeScreenRecording { }`
    public static func oy_observeScreenRecording(_ closure: @escaping () -> Void) {
        _ = NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            closure()
        }
    }

    /// `UIApplication.oy_changeAppIcon(name: "icon-2") { result in
    /// `    switch result {
    /// `    case .failure(let error):
    /// `        print(error)
    /// `    case .success(let result):
    /// `        print(result)
    /// `    }
    /// `}
    public static func oy_changeAppIcon(name: String, closure: ((Result<Bool, OYError>) -> Void)?) {
        guard UIApplication.shared.supportsAlternateIcons else {
            closure?(.failure(.alternateIconsNotSupported))
            return
        }

        UIApplication.shared.setAlternateIconName(name) { error in
            guard error != nil else {
                closure?(.success(true))
                return
            }
            closure?(.failure(.iconNotFound))
        }
    }

    /// `UIApplication.oy_isReachable` → output → true
    public static var oy_isReachable: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }),
            var flags = SCNetworkReachabilityFlags() as SCNetworkReachabilityFlags?,
            SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) else { return false }
        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }

    /// `UIApplication.oy_openSafari(url: URL(string: "http://www.apple.com"))`
    public static func oy_openSafari(url: URL?, entersReaderIfAvailable: Bool = false) throws {
        if let url = url {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = entersReaderIfAvailable

            let safariViewController = SFSafariViewController(url: url, configuration: config)
            oy_topViewController()?.present(safariViewController, animated: true)
        } else {
            throw OYError.urlIsNotValid
        }
    }

    /// Open external maps app by address
    /// `try UIApplication.oy_navigateToMaps(address: "California", type: .appleMaps)`
    public static func oy_openMaps(address: String, type: MapsType = .anyone) throws {
        let appleMapsUrl = URL(string: "https://maps.apple.com/?address=\(address)")
        let googleMapsUrl = URL(string: "comgooglemaps://?q=\(address)")

        if type == .appleMaps, let appleMapsUrl = appleMapsUrl {
            try oy_open(urls: appleMapsUrl)
        } else if type == .googleMaps, let googleMapsUrl = googleMapsUrl {
            try oy_open(urls: googleMapsUrl)
        } else if type == .yandexMaps {
            throw OYError.yandexMapsNotSupportedByAddress
        } else {
            var actions = [OYAction]()

            if let appleMapsUrl = appleMapsUrl, oy_canOpen(url: appleMapsUrl) {
                actions.append(OYAction(title: MapsType.appleMaps.title, style: .default))
            }

            if let googleMapsUrl = googleMapsUrl, oy_canOpen(url: googleMapsUrl) {
                actions.append(OYAction(title: MapsType.googleMaps.title, style: .default))
            }

            actions.append(OYAction(title: "Cancel", style: .cancel))

            UIAlertController.oy_showActionSheet(title: nil, message: nil, actions: actions) { selectedIndex in
                if let appleMapsUrl = appleMapsUrl, selectedIndex == 0 {
                    try? oy_open(urls: appleMapsUrl)
                } else if let googleMapsUrl = googleMapsUrl, selectedIndex == 1 {
                    try? oy_open(urls: googleMapsUrl)
                }
            }
        }
    }

    /// Open external maps app by latitude and longitude
    /// `try UIApplication.oy_navigateToMaps(latitude: "37.1930123", longitude: "-123.7992859", type: .appleMaps)`
    public static func oy_openMaps(latitude: String, longitude: String, type: MapsType = .anyone) throws {
        let appleMapsUrl = URL(string: "https://maps.apple.com/?daddr=\(latitude),\(longitude)")
        let googleMapsUrl = URL(string: "comgooglemaps://?daddr=\(latitude),\(longitude)")
        let yandexMapsUrl = URL(string: "yandexnavi://build_route_on_map?lat_to=\(latitude)&lon_to=\(longitude)")

        if type == .appleMaps, let appleMapsUrl = appleMapsUrl {
            try oy_open(urls: appleMapsUrl)
        } else if type == .googleMaps, let googleMapsUrl = googleMapsUrl {
            try oy_open(urls: googleMapsUrl)
        } else if type == .yandexMaps, let yandexMapsUrl = yandexMapsUrl {
            try oy_open(urls: yandexMapsUrl)
        } else {
            var actions = [OYAction]()

            if let url = appleMapsUrl, oy_canOpen(url: url) {
                actions.append(OYAction(title: MapsType.appleMaps.title, style: .default))
            }

            if let url = googleMapsUrl, oy_canOpen(url: url) {
                actions.append(OYAction(title: MapsType.googleMaps.title, style: .default))
            }

            if let url = yandexMapsUrl, oy_canOpen(url: url) {
                actions.append(OYAction(title: MapsType.yandexMaps.title, style: .default))
            }

            actions.append(OYAction(title: "Cancel", style: .cancel))

            UIAlertController.oy_showActionSheet(title: nil, message: nil, actions: actions) { selectedIndex in
                if let url = appleMapsUrl, selectedIndex == 0 {
                    try? oy_open(urls: url)
                } else if let url = googleMapsUrl, selectedIndex == 1 {
                    try? oy_open(urls: url)
                } else if let url = yandexMapsUrl, selectedIndex == 2 {
                    try? oy_open(urls: url)
                }
            }
        }
    }

    /// Open Facebook profile with profile id
    /// - Parameter profileId: Facebook id (find facebook id with https://lookup-id.com)
    public static func oy_openWithFacebook(profileId: String?) throws {
        guard let id = profileId, let url = URL(string: "fb://profile/\(id)") else {
            throw OYError.facebookIdIsNotValid
        }

        if oy_canOpen(url: url) {
            try oy_open(urls: url)
        } else if !((Bundle.main.oy_infoPlistValue(key: "LSApplicationQueriesSchemes") as? [String])?.contains("fb") ?? true) {
            throw OYError.facebookSchemeIsNotDeclared
        } else {
            try oy_openWithFacebook(profileName: profileId)
        }
    }

    /// Open Facebook profile with profile name
    /// - Parameter profileName: Facebook profile name
    public static func oy_openWithFacebook(profileName: String?) throws {
        guard let name = profileName, let url = URL(string: "https://www.facebook.com/\(name)") else {
            throw OYError.facebookNameIsNotValid
        }

        if oy_canOpen(url: url) {
            try oy_open(urls: url)
        } else {
            try oy_openSafari(url: url)
        }
    }

    /// Open Instagram profile with user name
    /// - Parameter username: Instagram user name
    public static func oy_openWithInstagram(username: String?) throws {
        guard let name = username, let url = URL(string: "instagram://user?username=\(name)") else {
            throw OYError.instagramNameIsNotValid
        }

        if oy_canOpen(url: url) {
            try oy_open(urls: url)
        } else {
            try oy_openSafari(url: url)
        }
    }

    /// Open Instagram profile with media id
    /// - Parameter mediaId: Instagram user name
    public static func oy_openWithInstagram(mediaId: String?) throws {
        guard let id = mediaId, let url = URL(string: "instagram://media?id=\(id)") else {
            throw OYError.instagramMediaIdIsNotValid
        }

        if oy_canOpen(url: url) {
            try oy_open(urls: url)
        } else {
            try oy_openSafari(url: url)
        }
    }
}

extension UIApplication {
    public enum MapsType {
        /// Apple Maps
        case appleMaps

        /// Google Maps
        case googleMaps

        /// Yandex Maps
        case yandexMaps

        /// Open UIAlertController with .actionSheet style
        case anyone

        var title: String {
            switch self {
            case .appleMaps: return "Apple Maps"
            case .googleMaps: return "Google Maps"
            case .yandexMaps: return "Yandex Maps"
            case .anyone: return ""
            }
        }
    }
}
