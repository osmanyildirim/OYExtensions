//
//  CLLocationCoordinate2D+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

#if canImport(CoreLocation)
    import CoreLocation
#endif

extension CLLocationCoordinate2D: Equatable {
    /// Compare coordinates
    /// - Parameters:
    ///   - lhs: first coordinate
    ///   - rhs: second coordinate
    /// - Returns: returns true if the coordinates are equal
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
