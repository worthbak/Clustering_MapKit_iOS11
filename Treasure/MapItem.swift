//
//  MapItem.swift
//  Treasure
//
//  Created by Worth Baker on 1/31/18.
//

import MapKit

final class MapItem: NSObject, MKAnnotation {
    enum ItemType: UInt32 {
        case green = 0
        case orange = 1
        
        var image: UIImage {
            switch self {
            case .green:
                return #imageLiteral(resourceName: "annotation")
            case .orange:
                return #imageLiteral(resourceName: "annotation_orange")
            }
        }
    }
    
    let coordinate: CLLocationCoordinate2D
    let itemType: ItemType
    var image: UIImage { return itemType.image }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.itemType = ItemType(rawValue: arc4random_uniform(2)) ?? .green
    }
}
