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
            
            displayPriority = .defaultHigh
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            let renderer = UIGraphicsImageRenderer(size: rect.size)
            
            let totalCount = cluster.memberAnnotations.count
            let orangeCount = cluster
                .memberAnnotations
                .flatMap { $0 as? MapItem }
                .filter { $0.itemType == .orange }
                .count

            let countText = "\(totalCount)"
            let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                               NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
            let textSize = countText.size(withAttributes: attributes)
            let textRect = CGRect(x: (rect.width / 2) - (textSize.width / 2),
                                  y: (rect.height / 2) - (textSize.height / 2),
                                  width: textSize.width,
                                  height: textSize.height)
            
            self.image = renderer.image { _ in
                UIColor(red: 126 / 255.0, green: 211 / 255.0, blue: 33 / 255.0, alpha: 1.0).setFill()
                UIBezierPath(ovalIn: rect).fill()
                
                UIColor(red: 245 / 255.0, green: 166 / 255.0, blue: 35 / 255.0, alpha: 1.0).setFill()
                let piePath = UIBezierPath()
                piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                               startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(orangeCount)) / CGFloat(totalCount),
                               clockwise: true)
                piePath.addLine(to: CGPoint(x: 20, y: 20))
                piePath.close()
                piePath.fill()
                
                UIColor.white.setFill()
                UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
                
                countText.draw(in: textRect, withAttributes: attributes)
            }
        }
    }
    
}
