//
//  ClusterAnnotationView.swift
//  Treasure
//
//  Created by Worth Baker on 2/11/18.
//  Copyright © 2018 HouseCanary. All rights reserved.
//

import UIKit
import MapKit

final class ClusterAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let cluster = annotation as? MKClusterAnnotation else { return }
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
            displayPriority = .defaultHigh
        }
    }
}
