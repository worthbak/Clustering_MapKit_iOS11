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
    
    private static let sharedClusterImage = #imageLiteral(resourceName: "cluster_empty")
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let cluster = annotation as? MKClusterAnnotation else { return }
            
            displayPriority = .defaultHigh
            let clusterImage = ClusterAnnotationView.sharedClusterImage
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            let renderer = UIGraphicsImageRenderer(size: rect.size)
            
            let countText = "\(cluster.memberAnnotations.count)"
            let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.white,
                               NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
            let textSize = countText.size(withAttributes: attributes)
            let textRect = CGRect(x: (rect.width / 2) - (textSize.width / 2),
                                  y: (rect.height / 2) - (textSize.height / 2),
                                  width: textSize.width,
                                  height: textSize.height)
            
            self.image = renderer.image { _ in
                clusterImage.draw(in: rect)
                countText.draw(in: textRect, withAttributes: attributes)
            }
        }
    }
    
}
