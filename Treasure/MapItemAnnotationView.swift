//
//  MapItemAnnotationView.swift
//  Treasure
//
//  Created by Worth Baker on 2/11/18.
//  Copyright © 2018 HouseCanary. All rights reserved.
//

import MapKit

final class MapItemAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let mapItem = annotation as? MapItem else { return }
            clusteringIdentifier = "MapItem"
            displayPriority = .defaultHigh
            
            image = mapItem.image
        }
    }
    
}
