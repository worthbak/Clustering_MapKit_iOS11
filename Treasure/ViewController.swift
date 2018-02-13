//
//  ViewController.swift
//  Treasure
//
//  Created by Worth Baker on 1/27/18.
//

import UIKit
import MapKit

final class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.register(
            MapItemAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(
            ClusterAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: 40.0166, longitude: -105.2817)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: false)
        
        for randCoordinate in makeRandomCoordinates(in: region) {
            let annotation = MapItem(coordinate: randCoordinate)
            mapView.addAnnotation(annotation)
        }
    }
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard view is ClusterAnnotationView else { return }
        
        // if the user taps a cluster, zoom in
        let currentSpan = mapView.region.span
        let zoomSpan = MKCoordinateSpan(latitudeDelta: currentSpan.latitudeDelta / 2.0, longitudeDelta: currentSpan.longitudeDelta / 2.0)
        let zoomCoordinate = view.annotation?.coordinate ?? mapView.region.center
        let zoomed = MKCoordinateRegion(center: zoomCoordinate, span: zoomSpan)
        mapView.setRegion(zoomed, animated: true)
    }
}
