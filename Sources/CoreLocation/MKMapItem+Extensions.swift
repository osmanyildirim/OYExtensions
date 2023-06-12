//
//  MKMapItem+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

#if canImport(MapKit)
    import MapKit
#endif

extension MKMapItem {
    /// Initializer method of MKMapItem
    /// - Parameters:
    ///   - coordinate: coordinate of MKMapItem
    ///   - name: name of MKMapItem
    /// - Returns: MKMapItem with coordinate
    public static func oy_init(coordinate: CLLocationCoordinate2D, name: String) -> MKMapItem {
        let item = MKMapItem(placemark: .init(coordinate: coordinate))
        item.name = name
        return item
    }
}
