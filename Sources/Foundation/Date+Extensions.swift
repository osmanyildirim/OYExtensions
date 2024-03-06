//
//  Date+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Date {
    /// `Date.oy_current` → output → 2022-10-19 00:03:06 +0000
    public static var oy_current: Date {
        Date()
    }

    /// `Date.oy_init(year: 2000, month: 05, day: 17, hour: 21, minute: 45, second: 38)`
    public static func oy_init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Self {
        var date = Date.oy_current
        date.oy_year = year
        date.oy_month = month
        date.oy_day = day
        date.oy_hour = hour
        date.oy_minute = minute
        date.oy_second = second
        return date
    }

    /// `Date.oy_init(string: "17.05.2000 21:45:38", format: .default)`
    public static func oy_init(string: String, format: OYDateFormat = .default) -> Self? {
        format.dateFormatter.date(from: string)
    }

    /// `Date.oy_current.oy_string(format: .default)` → output → "17.05.2000 21:45:38"
    public func oy_string(format: OYDateFormat = .default) -> String {
        format.dateFormatter.string(from: self)
    }
    
    /// `date1.oy_formatted(as: .isoDate)` → output → "2023-02-03"
    /// `date1.oy_formatted(as: .combined)` → output → "0302202312452200"
    /// `date1.oy_formatted(as: .time)` → output → "12:45:22"
    public func oy_formatted(as format: OYDateFormat, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format.format
        return dateFormatter.string(from: self)
    }

    /// `Date.oy_current.oy_string(format: .default)` → output → 958589138
    public var oy_timeStamp: Int {
        Int(timeIntervalSinceNow)
    }

    /// `Date.oy_current.oy_year` → output → 2000
    /// `Date.oy_current.oy_year = 2001`
    public var oy_year: Int {
        get {
            Calendar.current.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            self = addComponents(quarters: 0, years: newValue - oy_year, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        }
    }

    /// `Date.oy_current.oy_month` → output → 5
    /// `Date.oy_current.oy_month = 6`
    public var oy_month: Int {
        get {
            Calendar.current.component(.month, from: self)
        }
        set {
            let range = Calendar.current.range(of: .month, in: .year, for: self)!
            guard range.contains(newValue) else { return }
            self = addComponents(quarters: 0, years: 0, months: newValue - oy_month, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        }
    }

    /// `Date.oy_current.oy_weekOfYear` → output → 20
    /// `Date.oy_current.oy_weekOfYear = 21`
    public var oy_weekOfYear: Int {
        Calendar.current.component(.weekOfYear, from: self)
    }

    /// `Date.oy_current.oy_weekOfMonth` → output → 3
    /// `Date.oy_current.oy_weekOfMonth = 4`
    public var oy_weekOfMonth: Int {
        Calendar.current.component(.weekOfMonth, from: self)
    }

    /// `Date.oy_current.oy_day` → output → 17
    /// `Date.oy_current.oy_day = 18`
    public var oy_day: Int {
        get {
            Calendar.current.component(.day, from: self)
        }
        set {
            let range = Calendar.current.range(of: .day, in: .month, for: self)!
            guard range.contains(newValue) else { return }
            self = addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: newValue - oy_day, hours: 0, minutes: 0, seconds: 0)
        }
    }

    /// `Date.oy_current.oy_day` → output → 21
    /// `Date.oy_current.oy_day = 22`
    public var oy_hour: Int {
        get {
            Calendar.current.component(.hour, from: self)
        }
        set {
            let range = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard range.contains(newValue) else { return }
            self = addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: newValue - oy_hour, minutes: 0, seconds: 0)
        }
    }

    /// `Date.oy_current.oy_minute` → output → 45
    /// `Date.oy_current.oy_minute = 46`
    public var oy_minute: Int {
        get {
            Calendar.current.component(.minute, from: self)
        }
        set {
            let range = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard range.contains(newValue) else { return }
            self = addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: newValue - oy_minute, seconds: 0)
        }
    }

    /// `Date.oy_current.oy_minute` → output → 38
    /// `Date.oy_current.oy_minute = 39`
    public var oy_second: Int {
        get {
            Calendar.current.component(.second, from: self)
        }
        set {
            let range = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard range.contains(newValue) else { return }
            self = addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: newValue - oy_second)
        }
    }

    /// `Date.oy_current.oy_isWorkday` → output → true
    public var oy_isWorkday: Bool {
        !Calendar.current.isDateInWeekend(self)
    }

    /// `Date.oy_current.oy_isWeekend` → output → false
    public var oy_isWeekend: Bool {
        Calendar.current.isDateInWeekend(self)
    }

    /// `Date.oy_current.oy_isToday` → output → true
    public var oy_isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// `Date.oy_current.oy_isYesterday` → output → false
    public var oy_isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    /// `Date.oy_current.oy_isTomorrow` → output → false
    public var oy_isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    /// `Date.oy_current.oy_isInCurrentWeek` → output → true
    public var oy_isInCurrentWeek: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// `Date.oy_current.oy_isInCurrentMonth` → output → true
    public var oy_isInCurrentMonth: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    /// `Date.oy_current.oy_isInCurrentYear` → output → true
    public var oy_isInCurrentYear: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    /// `Date.oy_current.oy_isInFuture` → output → false
    public var oy_isInFuture: Bool {
        self > Date()
    }

    /// `Date.oy_current.oy_isInPast` → output → true
    public var oy_isInPast: Bool {
        self < Date()
    }
    
    /// `date1.oy_isBetween(start: date2, end: date3)` → output → true
    public func oy_isBetween(start: Date, end: Date) -> Bool {
        (min(start, end) ... max(start, end)).contains(self)
    }

    /// `date.oy_add(to: .year, value: 1)` → output → 2023-10-19 04:03:06 +0000
    /// `date.oy_add(to: .month, value: 1)` → output → 2022-11-19 04:03:06 +0000
    /// `date.oy_add(to: .week, value: 1)` → output → 2022-10-26 04:03:06 +0000
    /// `date.oy_add(to: .day, value: 1)` → output → 2022-10-20 04:03:06 +0000
    /// `date.oy_add(to: .hour, value: 1)` → output → 2022-10-19 05:03:06 +0000
    /// `date.oy_add(to: .minute, value: 1)` → output → 2022-10-19 04:04:06 +0000
    /// `date.oy_add(to: .second, value: 1)` → output → 2022-10-19 04:03:07 +0000
    public mutating func oy_add(to: Component, value: Int) {
        switch to {
        case .year: self = self.addComponents(quarters: 0, years: value, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        case .month: self = self.addComponents(quarters: 0, years: 0, months: value, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        case .week: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: value, days: 0, hours: 0, minutes: 0, seconds: 0)
        case .day: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: value, hours: 0, minutes: 0, seconds: 0)
        case .hour: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: value, minutes: 0, seconds: 0)
        case .minute: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: value, seconds: 0)
        case .second: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: value)
        }
    }

    /// `date.oy_subtract(to: .year, value: 1)` → output → 2021-10-19 04:03:06 +0000
    /// `date.oy_subtract(to: .month, value: 1)` → output → 2022-09-19 04:03:06 +0000
    /// `date.oy_subtract(to: .week, value: 1)` → output → 2022-10-12 04:03:06 +0000
    /// `date.oy_subtract(to: .day, value: 1)` → output → 2022-10-18 04:03:06 +0000
    /// `date.oy_subtract(to: .hour, value: 1)` → output → 2022-10-19 03:03:06 +0000
    /// `date.oy_subtract(to: .minute, value: 1)` → output → 2022-10-19 04:2:06 +0000
    /// `date.oy_subtract(to: .second, value: 1)` → output → 2022-10-19 04:03:05 +0000
    public mutating func oy_subtract(from: Component, value: Int) {
        switch from {
        case .year: self = self.addComponents(quarters: 0, years: -value, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        case .month: self = self.addComponents(quarters: 0, years: 0, months: -value, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
        case .week: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: -value, days: 0, hours: 0, minutes: 0, seconds: 0)
        case .day: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: -value, hours: 0, minutes: 0, seconds: 0)
        case .hour: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: -value, minutes: 0, seconds: 0)
        case .minute: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: -value, seconds: 0)
        case .second: self = self.addComponents(quarters: 0, years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: -value)
        }
    }

    /// `Date.oy_difference(of: .year, date1: date1, date2: date2)` → output → 4
    /// `Date.oy_difference(of: .month, date1: date1, date2: date2)` → output → 6
    /// `Date.oy_difference(of: .week, date1: date1, date2: date2)` → output → 2
    /// `Date.oy_difference(of: .day, date1: date1, date2: date2)` → output → 3
    /// `Date.oy_difference(of: .hour, date1: date1, date2: date2)` → output → 8
    /// `Date.oy_difference(of: .minute, date1: date1, date2: date2)` → output → 17
    /// `Date.oy_difference(of: .second, date1: date1, date2: date2)` → output → 33
    public static func oy_difference(of: Calendar.Component, date1 d1: Date, date2 d2: Date) throws -> Int {
        let diff = Calendar.current.dateComponents([of], from: d1, to: d2)
        var result: Int?

        switch of {
        case .year: result = diff.year
        case .month: result = diff.month
        case .weekOfYear: result = diff.weekOfYear
        case .day: result = diff.day
        case .hour: result = diff.hour
        case .minute: result = diff.minute
        case .second: result = diff.second
        default: result = 0
        }

        guard let result else { throw OYError.valueIsNil }
        return abs(result)
    }

    /// `date.oy_difference(of: .year, from: date1)` → output → 4
    /// `date.oy_difference(of: .month, from: date1)` → output → 6
    /// `date.oy_difference(of: .week, from: date1)` → output → 2
    /// `date.oy_difference(of: .day, from: date1)` → output → 3
    /// `date.oy_difference(of: .hour, from: date1)` → output → 8
    /// `date.oy_difference(of: .minute, from: date1)` → output → 17
    /// `date.oy_difference(of: .second, from: date1)` → output → 33
    public func oy_difference(of: Calendar.Component, from date: Date) throws -> Int {
        try Self.oy_difference(of: of, date1: date, date2: self)
    }
    
    /// date1 is "03.02.2023 12:45"
    /// `date1.oy_start(of: .year)` → output → "01.01.2023 00:00:00"
    /// `date1.oy_start(of: .month)` → output → "01.02.2023 00:00:00"
    /// `date1.oy_start(of: .hour)` → output → "03.02.2023 12:00:00"
    /// `date1.oy_start(of: .minute)` → output → "03.02.2023 12:45:00"
    public func oy_start(of component: Calendar.Component) -> Date {
        if component == .day {
            return Calendar.current.startOfDay(for: self)
        }
        var components: Set<Calendar.Component> {
            switch component {
            case .second: return [.year, .month, .day, .hour, .minute, .second]
            case .minute: return [.year, .month, .day, .hour, .minute]
            case .hour: return [.year, .month, .day, .hour]
            case .day: return [.year, .month, .day]
            case .weekOfYear, .weekOfMonth: return [.yearForWeekOfYear, .weekOfYear]
            case .month: return [.year, .month]
            case .year: return [.year]
            default: return []
            }
        }
        guard components.isEmpty == false else { return self }
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self)) ?? self
    }
    
    /// date1 is "03.02.2023 12:45"
    /// `date1.oy_end(of: .year)` → output → "31.12.2023 23:59:59"
    /// `date1.oy_end(of: .month)` → output → "29.02.2023 23:59:59"
    /// `date1.oy_end(of: .hour)` → output → "03.02.2023 12:59:59"
    /// `date1.oy_end(of: .minute)` → output → "03.02.2023 12:45:59"
    public func oy_end(of component: Calendar.Component) -> Date {
        let date = oy_start(of: component)
        var components: DateComponents? {
            switch component {
            case .second:
                var components = DateComponents()
                components.second = 1
                components.nanosecond = -1
                return components
            case .minute:
                var components = DateComponents()
                components.minute = 1
                components.second = -1
                return components
            case .hour:
                var components = DateComponents()
                components.hour = 1
                components.second = -1
                return components
            case .day:
                var components = DateComponents()
                components.day = 1
                components.second = -1
                return components
            case .weekOfYear, .weekOfMonth:
                var components = DateComponents()
                components.weekOfYear = 1
                components.second = -1
                return components
            case .month:
                var components = DateComponents()
                components.month = 1
                components.second = -1
                return components
            case .year:
                var components = DateComponents()
                components.year = 1
                components.second = -1
                return components
            default:
                return nil
            }
        }
        guard let addedComponent = components else { return self }
        return Calendar.current.date(byAdding: addedComponent, to: date) ?? self
    }
}

// MARK: - Calendar.Component
extension Date {
    /// Unit Styles
    /// `.abbreviated` → 3 min. ago
    /// `.full` → 3 minutes ago
    /// `.short` → 3 min. ago
    /// ‌`.spellOut` → three minutes ago
    
    /// `Date.oy_localizedString(type: .hour, numberOfUnits: 2, locale: .init(identifier: "en"), unitsStyle: .abbreviated)` →  "2h"
    /// `Date.oy_localizedString(type: .day, numberOfUnits: 12, locale: .init(identifier: "en"), unitsStyle: .full)` →  "12 days"
    /// `Date.oy_localizedString(type: .month, numberOfUnits: 3, locale: .init(identifier: "en"), unitsStyle: .short)` →  "3 mths"
    /// `Date.oy_localizedString(type: .year, numberOfUnits: -5, locale: .init(identifier: "en"), unitsStyle: .spellOut)` →  "minus five years"
    public static func oy_localizedString(type: Calendar.Component, numberOfUnits: Int, locale: Locale = Locale.current, unitsStyle: DateComponentsFormatter.UnitsStyle = .full) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.calendar?.locale = locale
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = unitsStyle
        formatter.zeroFormattingBehavior = .dropAll
        
        var dateComponents = DateComponents()
        dateComponents.setValue(numberOfUnits, for: type)
        return formatter.string(from: dateComponents)
    }
}

// MARK: - RelativeDateTimeFormatter
@available(iOS 13.0, *) extension Date {
    /// Unit Styles
    /// `.abbreviated` → 3 min. ago
    /// `.full` → 3 minutes ago
    /// `.short` → 3 min. ago
    /// ‌`.spellOut` → three minutes ago
    
    /// `Date.oy_localizedString(interval: 60 * 1440 * 30, locale: .init(identifier: "en"), unitsStyle: .full)` →  "in 1 month"
    /// `Date.oy_localizedString(interval: 60 * 1440, locale: .init(identifier: "en"), unitsStyle: .spellOut)` → "in one day"
    /// `Date.oy_localizedString(interval: 60 * 1440 * 21, locale: .init(identifier: "en"), unitsStyle: .short)` → "in 3 wk."
    /// `Date.oy_localizedString(interval: -60, locale: .init(identifier: "en"), unitsStyle: .abbreviated)` → "1 min. ago"
    public static func oy_localizedString(interval: TimeInterval, locale: Locale = Locale.current, unitsStyle: RelativeDateTimeFormatter.UnitsStyle = .full) -> String {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.locale = locale
        relativeDateTimeFormatter.unitsStyle = unitsStyle
        return relativeDateTimeFormatter.localizedString(fromTimeInterval: interval)
    }
    
    /// `Date.oy_localizedString(dateComponents: DateComponents(month: 1), locale: .init(identifier: "en"), unitsStyle: .full)` → "in 1 month"
    /// `Date.oy_localizedString(dateComponents: DateComponents(year: -2), locale: .init(identifier: "en"), unitsStyle: .spellOut)` → "two years ago"
    /// `Date.oy_localizedString(dateComponents: DateComponents(hour: 12), locale: .init(identifier: "en"), unitsStyle: .short)` → "in 12 hr."
    /// `Date.oy_localizedString(dateComponents: DateComponents(day: -17), locale: .init(identifier: "en"), unitsStyle: .abbreviated)` → "17 days ago"
    public static func oy_localizedString(dateComponents: DateComponents, locale: Locale = Locale.current, unitsStyle: RelativeDateTimeFormatter.UnitsStyle = .full) -> String {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.locale = locale
        relativeDateTimeFormatter.unitsStyle = unitsStyle
        return relativeDateTimeFormatter.localizedString(from: dateComponents)
    }
    
    /// `date1.oy_localizedString(relativeTo: date2, locale: .init(identifier: "en"), unitsStyle: .full)` → "in 1 month"
    /// `date1.oy_localizedString(relativeTo: date2, locale: .init(identifier: "en"), unitsStyle: .spellOut)` → "in one day"
    /// `date1.oy_localizedString(relativeTo: date2, locale: .init(identifier: "en"), unitsStyle: .short)` → "in 12 hr."
    /// `date1.oy_localizedString(relativeTo: date2, locale: .init(identifier: "en"), unitsStyle: .abbreviated)` → "1 min. ago"
    public func oy_localizedString(relativeTo: Date, locale: Locale = Locale.current, unitsStyle: RelativeDateTimeFormatter.UnitsStyle = .full) -> String {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.locale = locale
        relativeDateTimeFormatter.unitsStyle = unitsStyle
        return relativeDateTimeFormatter.localizedString(for: self, relativeTo: relativeTo)
    }
}

extension Date {
    public enum Component {
        case year
        case month
        case week
        case day
        case hour
        case minute
        case second
    }

    private func addComponents(quarters: Int, years: Int, months: Int, weeks: Int, days: Int, hours: Int, minutes: Int, seconds: Int) -> Date {
        var components = DateComponents()
        components.quarter = quarters
        components.year = years
        components.month = months
        components.weekOfYear = weeks
        components.day = days
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        return Calendar.current.date(byAdding: components, to: self)!
    }
}

extension String {
    /// `"17-05-2023".oy_date(format: .short)` → output → (Date) $R0 = 2023-05-17 00:00:00 UTC
    public func oy_date(format: OYDateFormat = .default) -> Date? {
        format.dateFormatter.date(from: self)
    }
}
