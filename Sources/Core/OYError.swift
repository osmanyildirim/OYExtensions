//
//  OYError.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

public enum OYError: Error {
    /// Should the index be within the valid range
    case indexOutOfBounds
    
    /// Image couldn't downloaded from url
    case imageNotDownload
    
    /// Value is nil
    case valueIsNil
    
    /// URL is not valid
    case urlIsNotValid
    
    /// Data is not valid
    case invalidData
    
    /// Facebook scheme isn't valid for UIApplication.shared.open
    case facebookIdIsNotValid
    
    /// Facebook scheme isn't declared for UIApplication.shared.open
    case facebookSchemeIsNotDeclared
    
    /// Facebook name isn't valid for UIApplication.shared.open
    case facebookNameIsNotValid
    
    /// Instagram name isn't valid for UIApplication.shared.open
    case instagramNameIsNotValid
    
    /// Instagram media id isn't valid for UIApplication.shared.open
    case instagramMediaIdIsNotValid
    
    /// Phone number isn't valid for call phone
    case phoneNumberIsNotValid
    
    /// Icon couldn't found for change AppIcon
    case iconNotFound
    
    /// Alternate icon couldn't found for change AppIcon
    case alternateIconsNotSupported
    
    /// Yandex Maps doesn't support to open maps by address
    case yandexMapsNotSupportedByAddress
    
    /// Converting Data to String failed
    case stringToDataFailed
    
    /// Decrypting Data failed
    case decryptingDataFailed
    
    /// Converting String to Data failed
    case dataToStringFailed
    
    /// User denies authorization to access tracking
    case advertisingTrackingIsNotEnabled
    
    /// Permission could not be declared
    case permissionError
}
