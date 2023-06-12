//
//  MKMapView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

#if canImport(MapKit)
    import MapKit
#endif

extension MKMapView {
    /// Register MKAnnotationView
    /// - Parameter name: MKAnnotationView type
    public func oy_register<T: MKAnnotationView>(annotationViewWithClass name: T.Type) {
        register(T.self, forAnnotationViewWithReuseIdentifier: T.oy_reuseIdentifier)
    }

    /// Dequeue reusable MKAnnotationView
    /// - Parameter type: MKAnnotationView type
    /// - Returns: optional MKAnnotationView object
    public func oy_dequeueReusableAnnotationView<A: MKAnnotationView>(_ type: A.Type) -> A? {
        guard let view = dequeueReusableAnnotationView(withIdentifier: type.oy_reuseIdentifier) as? A else {
            fatalError("\(#function) Unable to dequeue annotation view of type `\(type)`")
        }
        return view
    }

    /// Dequeue reusable MKAnnotationView
    /// - Parameters:
    ///   - type: MKAnnotationView type
    ///   - annotation: annotation of the MKMapView
    /// - Returns: optional MKAnnotationView object
    public func oy_dequeueReusableAnnotationView<A: MKAnnotationView>(_ type: A.Type, for annotation: MKAnnotation) -> A? {
        guard let view = dequeueReusableAnnotationView(withIdentifier: type.oy_reuseIdentifier, for: annotation) as? A else {
            fatalError("Couldn't find MKAnnotationView for `\(type)`")
        }
        return view
    }

    /// Span of the map and fit the aspect ratio of the view
    /// - Parameters:
    ///   - location: coordinate of point
    ///   - level: zoom level. etc: 150
    ///   - animated: if the should be animated
    public func oy_setRegion(location: CLLocationCoordinate2D, level: Double, animated: Bool) {
        guard let level = CLLocationDistance(exactly: level) else { return }
        let region = MKCoordinateRegion(center: location, latitudinalMeters: level, longitudinalMeters: level)
        setRegion(regionThatFits(region), animated: animated)
    }

    /// Hide the `Legal` label in the lower left
    public func oy_hideLabels() {
        subviews.oy_item(at: 1)?.isHidden = true
        subviews.oy_item(at: 2)?.isHidden = true
    }

    /// Add MKPointAnnotation
    /// - Parameters:
    ///   - coordinate: coordinate of MKPointAnnotation
    ///   - title: title of MKPointAnnotation
    public func oy_addAnnotation(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        addAnnotation(annotation)
    }
}
