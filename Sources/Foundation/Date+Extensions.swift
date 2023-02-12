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
    public func oy_date(format: OYDateFormat = .default) -> Date {
        format.dateFormatter.date(from: self) ?? Date()
    }
}
