//
//  UIDevice+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit
#if canImport(AdSupport)
    import AdSupport
#endif
#if canImport(AppTrackingTransparency)
    import AppTrackingTransparency
#endif
#if canImport(AVFoundation)
    import AVFoundation
#endif

extension UIDevice {
    /// `UIDevice.oy_current` → output → <UIDevice: 0x6000013e0030>
    public static var oy_current: UIDevice {
        UIDevice.current
    }

    /// `UIDevice.oy_vendorId` → output → "98BBB96B-9A54-4285-8DBF-6BBC4AF0674C"
    public static var oy_vendorId: String? {
        oy_current.identifierForVendor?.uuidString
    }
    
    /// `UIDevice.oy_advertisingId` → output → "123e4567-e89b-12d3-a456–426614174000"
    /// Your app must request tracking authorization before it can get the advertising identifier
    public static func oy_advertisingId() throws -> String? {
        let identifierManager = ASIdentifierManager.shared()

        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus == .authorized {
                return identifierManager.advertisingIdentifier.uuidString
            }
        } else if identifierManager.isAdvertisingTrackingEnabled {
            return identifierManager.advertisingIdentifier.uuidString
        }
        throw OYError.advertisingTrackingIsNotEnabled
    }
    
    /// Create and return a brand new unique identifier
    ///  `UIDevice.oy_uuid` → output → "68FCCB58-23A5-47BC-AA56-E0757F1BDBEA"
    public static var oy_uuid: String {
        NSUUID().uuidString
    }

    /// `UIDevice.oy_deviceName` → output → "iPhone 14 Pro Max"
    public static var oy_deviceName: String {
        oy_current.name
    }

    /// `UIDevice.oy_modelName` → output → "Simulator iPhone 14 Pro Max"
    public static var oy_modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return oy_deviceModel(identifier)
    }

    /// `UIDevice.oy_systemName` → output → "iOS"
    public static var oy_systemName: String {
        oy_current.systemName
    }

    /// `UIDevice.oy_systemVersion` → output → "16.0"
    public static var oy_systemVersion: String {
        oy_current.systemVersion
    }

    /// `UIDevice.oy_systemVersionFloat` → output → 16.0
    public static var oy_systemVersionFloat: Float? {
        oy_systemVersion.oy_float
    }

    /// `UIDevice.oy_language` → output → "en"
    public static var oy_language: String? {
        Bundle.main.oy_langugage
    }

    /// `UIDevice.oy_isPhone` → output → true
    public static var oy_isPhone: Bool {
        oy_current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    /// `UIDevice.oy_isPad` → output → false
    public static var oy_isPad: Bool {
        oy_current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    /// `UIDevice.oy_hasNotch` → output → true
    public static var oy_hasNotch: Bool {
        let bottom = UIApplication.oy_keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }

    /// `UIDevice.oy_isJailbroken` → output → false
    public static var oy_isJailbroken: Bool {
        do {
            let path = "/private/jailbreak.txt"
            try "OyExtensions Jailbroken Detection Test Message".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }

    /// `UIDevice.oy_isMac` → output → false
    public static var oy_isMac: Bool {
        if #available(iOS 14.0, tvOS 14.0, *) {
            if UIDevice.current.userInterfaceIdiom == .mac {
                return true
            }
        }
        #if targetEnvironment(macCatalyst)
            return true
        #else
            return false
        #endif
    }
    
    /// On/Off device's torch (camera flash)
    public static func oy_toggleTorch(level: Float = 1.0) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }

        try? device.lockForConfiguration()

        if device.isTorchActive {
            device.torchMode = .off
        } else {
            try? device.setTorchModeOn(level: level)
        }

        device.unlockForConfiguration()
    }
}

extension UIDevice {
    /// Get device model by identifier
    private static func oy_deviceModel(_ identifier: String) -> String {
        #if os(iOS)
            switch identifier {
            case "iPod5,1": return "iPod touch (5th generation)"
            case "iPod7,1": return "iPod touch (6th generation)"
            case "iPod9,1": return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
            case "iPhone4,1": return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2": return "iPhone 5"
            case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
            case "iPhone7,2": return "iPhone 6"
            case "iPhone7,1": return "iPhone 6 Plus"
            case "iPhone8,1": return "iPhone 6s"
            case "iPhone8,2": return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3": return "iPhone 7"
            case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4": return "iPhone 8"
            case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6": return "iPhone X"
            case "iPhone11,2": return "iPhone XS"
            case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
            case "iPhone11,8": return "iPhone XR"
            case "iPhone12,1": return "iPhone 11"
            case "iPhone12,3": return "iPhone 11 Pro"
            case "iPhone12,5": return "iPhone 11 Pro Max"
            case "iPhone13,1": return "iPhone 12 mini"
            case "iPhone13,2": return "iPhone 12"
            case "iPhone13,3": return "iPhone 12 Pro"
            case "iPhone13,4": return "iPhone 12 Pro Max"
            case "iPhone14,4": return "iPhone 13 mini"
            case "iPhone14,5": return "iPhone 13"
            case "iPhone14,2": return "iPhone 13 Pro"
            case "iPhone14,3": return "iPhone 13 Pro Max"
            case "iPhone14,7": return "iPhone 14"
            case "iPhone14,8": return "iPhone 14 Plus"
            case "iPhone15,2": return "iPhone 14 Pro"
            case "iPhone15,3": return "iPhone 14 Pro Max"
            case "iPhone8,4": return "iPhone SE"
            case "iPhone12,8": return "iPhone SE (2nd generation)"
            case "iPhone14,6": return "iPhone SE (3rd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12": return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6": return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12": return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7": return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2": return "iPad (9th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
            case "iPad5,3", "iPad5,4": return "iPad Air 2"
            case "iPad11,3", "iPad11,4": return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2": return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17": return "iPad Air (5th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad mini 3"
            case "iPad5,1", "iPad5,2": return "iPad mini 4"
            case "iPad11,1", "iPad11,2": return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2": return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4": return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4": return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10": return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return "iPad Pro (11-inch) (3rd generation)"
            case "iPad6,7", "iPad6,8": return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2": return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12": return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return "iPad Pro (12.9-inch) (5th generation)"
            case "AppleTV5,3": return "Apple TV"
            case "AppleTV6,2": return "Apple TV 4K"
            case "AudioAccessory1,1": return "HomePod"
            case "AudioAccessory5,1": return "HomePod mini"
            case "i386", "x86_64", "arm64": return "Simulator \(oy_deviceModel(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default: return identifier
            }
        #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(oy_deviceModel(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
        #endif
    }
}
