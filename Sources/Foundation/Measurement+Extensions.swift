//
//  Measurement+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Measurement where UnitType == UnitAngle {
    /// let degrees = Measurement(value: 58, unit: UnitAngle.degrees)
    /// let radians = degrees.oy_convert(to: .radians)
    ///
    /// radians output:
    /// (Foundation.Measurement<UnitAngle>)
    /// 1.0122909661567112 rad
    ///  - value : 1.0122909661567112
    ///  - unit : "rad"
    public func oy_convert(to: UnitAngle) -> Measurement<UnitAngle> {
        converted(to: to)
    }
}

@available(iOS 13.0, *)
extension Measurement where UnitType == UnitInformationStorage {
    /// let bytes = Measurement(value: 1, unit: UnitInformationStorage.bytes)
    /// let bits = bytes.oy_convert(to: .bits)
    ///
    /// bits output:
    /// (Foundation.Measurement<UnitInformationStorage>)
    ///  - unit = 0x00000001b97dbd08 {}
    ///  - value = (_value = 8)
    public func oy_convert(to: UnitInformationStorage) -> Measurement<UnitInformationStorage> {
        converted(to: to)
    }
}

extension Measurement where UnitType == UnitLength {
    /// let meters = Measurement(value: 2100, unit: UnitLength.meters)
    /// let kilomerts = meters.oy_convert(to: .kilometers)
    ///
    /// kilomerts output:
    /// (Foundation.Measurement<UnitLength>)
    /// 2.1 km
    ///  - value : 2.1
    ///  - unit : "km"
    public func oy_convert(to: UnitLength) -> Measurement<UnitLength> {
        converted(to: to)
    }
}

extension Measurement where UnitType == UnitSpeed {
    /// let kilometersPerHour = Measurement(value: 100, unit: UnitSpeed.kilometersPerHour)
    /// let milesPerHour = kilometersPerHour.oy_convert(to: .milesPerHour)
    ///
    /// milesPerHour output:
    /// (Foundation.Measurement<UnitSpeed>)
    /// 62.13716893342878 mph
    ///  - value : 62.13716893342878
    ///  - unit : "mph"
    public func oy_convert(to: UnitSpeed) -> Measurement<UnitSpeed> {
        converted(to: to)
    }
}

extension Measurement where UnitType == UnitTemperature {
    /// let celcius = Measurement(value: 1, unit: UnitTemperature.celsius)
    /// let kelvin = celcius.oy_convert(to: .kelvin)
    ///
    /// kelvin output:
    /// (Foundation.Measurement<UnitTemperature>)
    /// 274.15 K
    ///  - value : 274.15
    ///  - unit : "K"
    public func oy_convert(to: UnitTemperature) -> Measurement<UnitTemperature> {
        converted(to: to)
    }
}
