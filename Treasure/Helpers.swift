//
//  Helpers.swift
//  Treasure
//
//  Created by Worth Baker on 1/30/18.
//

import UIKit
import MapKit

extension ViewController {
    
    func makeRandomCoordinates(_ number: Int = 1000, in region: MKCoordinateRegion) -> [CLLocationCoordinate2D] {
        let minLat = region.center.latitude - (region.span.latitudeDelta * 2)
        let maxLat = region.center.latitude + (region.span.latitudeDelta * 2)
        
        let minLon = region.center.longitude - (region.span.longitudeDelta)
        let maxLon = region.center.longitude + (region.span.longitudeDelta)
        
        let adjusted: [Int] = [minLat, maxLat, minLon, maxLon].map { Int($0 * 10000) }
        let latDelta = adjusted[1] - adjusted[0]
        let lonDelta = abs(adjusted[3] - adjusted[2])
        
        var coordinates = [CLLocationCoordinate2D]()
        for _ in 0...number {
            let latRand = Int(arc4random_uniform(UInt32(latDelta)))
            let lonRand = Int(arc4random_uniform(UInt32(lonDelta))) * -1
            
            let lat: Double = minLat + (Double(latRand) / 10000.0)
            let lon: Double = minLon - (Double(lonRand) / 10000.0)
            
            coordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
        
        return coordinates
    }
}

extension UIGraphicsImageRenderer {
    static func image(for annotations: [MKAnnotation], in rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        let totalCount = annotations.count
        let orangeCount = annotations.orangeCount
        
        let countText = "\(totalCount)"
        
        return renderer.image { _ in
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
            
            countText.drawForCluster(in: rect)
        }
    }
}

extension Sequence where Element == MKAnnotation {
    var orangeCount: Int {
        return self
            .flatMap { $0 as? MapItem }
            .filter { $0.itemType == .orange }
            .count
    }
}

extension String {
    func drawForCluster(in rect: CGRect) {
        let attributes = [ NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
        let textSize = self.size(withAttributes: attributes)
        let textRect = CGRect(x: (rect.width / 2) - (textSize.width / 2),
                              y: (rect.height / 2) - (textSize.height / 2),
                              width: textSize.width,
                              height: textSize.height)
        
        self.draw(in: textRect, withAttributes: attributes)
    }
}
