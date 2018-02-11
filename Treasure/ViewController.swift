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
        
        mapView.register(MapItemAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
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

