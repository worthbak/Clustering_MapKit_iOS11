//
//  MapItem.swift
//  Treasure
//
//  Created by Worth Baker on 1/31/18.
//

import MapKit

final class MapItem: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    var image: UIImage {
        return #imageLiteral(resourceName: "annotation")
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
