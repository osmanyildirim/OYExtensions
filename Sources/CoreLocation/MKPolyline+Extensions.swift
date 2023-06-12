//
//  MKPolyline+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

#if canImport(MapKit)
    import MapKit
#endif

extension MKPolyline {
    /// Initializer method of MKPolyline
    /// - Parameter coordinates: polyline coordinates array
    /// - Returns: MKPolyline with coordinates
    public static func oy_init(coordinates: [CLLocationCoordinate2D]) -> MKPolyline {
            .init(coordinates: coordinates, count: coordinates.count)
    }

    /// Initializer method of MKPolyline
    /// - Parameter points: polyline points array
    /// - Returns: MKPolyline with points
    public static func oy_init(points: [MKMapPoint]) -> MKPolyline {
            .init(points: points, count: points.count)
    }

    /// Coordinates array of MKPolyline
    public var oy_coordinates: [CLLocationCoordinate2D] {
        var coordinates = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coordinates, range: NSRange(location: 0, length: pointCount))
        return coordinates
    }
}
