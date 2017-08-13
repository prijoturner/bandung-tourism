//
//  DestinationAnnotation.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/21/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit
import MapKit

class DestinationAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var destination: NSDictionary?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, destination: NSDictionary) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.destination = destination
    }
}
