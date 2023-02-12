//
//  CLLocation+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import CoreLocation

extension CLLocation {
    /// Middle location between 2 locations
    /// - Parameter point: second location
    /// - Returns: middle location coordinate
    public func oy_middle(to point: CLLocation) -> CLLocation {
        CLLocation.oy_middle(start: self, end: point)
    }

    /// Middle location between 2 locations
    /// - Parameters:
    ///   - start: first location
    ///   - end: second location
    /// - Returns: middle location coordinate
    public static func oy_middle(start: CLLocation, end: CLLocation) -> CLLocation {
        let latitude_1 = Double.pi * start.coordinate.latitude / 180.0
        let longitude_1 = Double.pi * start.coordinate.longitude / 180.0
        let latitude_2 = Double.pi * end.coordinate.latitude / 180.0
        let longitude_2 = Double.pi * end.coordinate.longitude / 180.0

        let bxLoc = cos(latitude_2) * cos(longitude_2 - longitude_1)
        let byLoc = cos(latitude_2) * sin(longitude_2 - longitude_1)
        let mlat = atan2(sin(latitude_1) + sin(latitude_2), sqrt((cos(latitude_1) + bxLoc) * (cos(latitude_1) + bxLoc) + (byLoc * byLoc)))
        let mlong = (longitude_1) + atan2(byLoc, cos(latitude_1) + bxLoc)

        return CLLocation(latitude: (mlat * 180 / Double.pi), longitude: (mlong * 180 / Double.pi))
    }

    /// City and country of CLLocation
    ///
    /// Usage:
    ///
    ///             location.oy_cityAndCountry { city, country, error in
    ///                 city // CA
    ///                 country // The United States
    ///             }
    public func oy_cityAndCountry(completion: @escaping (_ city: String?, _ country: String?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.administrativeArea, $0?.first?.country, $1) }
    }

    /// Place informatin of CLLocation
    ///
    /// Usage:
    ///
    ///             location.oy_informations { place, error in
    ///                  place
    ///                  // 10614–10672 Bandley Dr, 10614–10672 Bandley Dr, Cupertino, CA  95014, The United States @ <+37.33167550,-122.03467370> +/- 100.00m, region CLCircularRegion (identifier:'<+37.33167522,-122.03471445> radius 70.65', center:<+37.33167522,-122.03471445>, radius:70.65m)
    ///              }
    public func oy_informations(completion: @escaping (_ place: CLPlacemark?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
