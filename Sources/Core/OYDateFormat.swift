//
//  OYDateFormat.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

public enum OYDateFormat {
    /// `dd.MM.yyyy HH:mm:ss`
    case `default`
    
    /// `dd-MM-yyyy`
    case short

    /// `dd.MM.yyyy`
    case shortDot

    /// `HH:mm:ss`
    case time
    
    /// `yyyy`
    case isoYear
    
    /// `yyyy-MM`
    case isoYearMonth
    
    /// `yyyy-MM-dd`
    case isoDate
    
    /// `yyyy-MM-dd'T'HH:mmZ`
    case isoDateTime
    
    /// `yyyy-MM-dd'T'HH:mm:ssZ`
    case isoDateTimeSec
    
    /// `yyyy-MM-dd'T'HH:mm:ss.SSSZ`
    case isoDateTimeMilliSec

    /// `yyyy-MM-dd'T'HH:mm:ss.SSS'Z'`
    case iso8601
    
    /// `ddMMyyyyHHmmssSS`
    case combined

    /// custom date format
    case custom(String)
}

extension OYDateFormat {
    var format: String {
        switch self {
        case .`default`: return "dd.MM.yyyy HH:mm:ss"
        case .short: return "dd-MM-yyyy"
        case .shortDot: return "dd.MM.yyyy"
        case .time: return "HH:mm:ss"
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .iso8601: return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case .combined: return "ddMMyyyyHHmmssSS"
        case .custom(let format): return format
        }
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = format
        return formatter
    }
}
