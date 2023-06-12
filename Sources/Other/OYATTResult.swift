//
//  OYATTResult.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

public enum OYATTResult {
    /// User authorizes access to app-related data for tracking
    case authorized
    
    /// User denies authorization to access app-related data for tracking
    case denied
    
    /// App can’t determine the user’s authorization status for access to app-related data for tracking
    case notDetermined
    
    /// Track setting is disabled and cannot be changed.
    case restricted
    
    /// Info.plist doesn't contain an NSUserTrackingUsageDescription key with a string value explaining to the user how the app uses this data
    case userTrackingUsageDescriptionNotDeclared
}
