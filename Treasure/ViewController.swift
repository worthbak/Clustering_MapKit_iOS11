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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let item = annotation as? MapItem {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "mapItem")
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "mapItem")
            
            annotationView.annotation = item
            annotationView.image = UIImage(named: "annotation")
            annotationView.clusteringIdentifier = "mapItemClustered"
            
            return annotationView
        } else if let cluster = annotation as? MKClusterAnnotation {
            let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: "clusterView")
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "clusterView")
            
            clusterView.annotation = cluster
            clusterView.image = UIImage(named: "cluster")
            
            return clusterView
        } else {
            return nil
        }
    }
}

