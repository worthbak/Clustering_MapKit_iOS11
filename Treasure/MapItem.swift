//
//  MapItem.swift
//  Treasure
//
//  Created by Worth Baker on 1/31/18.
//  Copyright © 2018 HouseCanary. All rights reserved.
//

import MapKit

final class MapItem: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
