//
//  Destination.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/21/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit
import MapKit

class Destination: NSObject {
    let imageName: String
    let title: String
    let subTitle: String
    let desc: String
    let latitude: Double
    let longitude: Double
    
    init(data: NSDictionary){
        self.imageName = data["imageName"] as! String
        self.title = data["title"] as! String
        self.subTitle = data["subTitle"] as! String
        self.desc = data["description"] as! String
        
        let latitude = data["latitude"] as! NSNumber
        let longitude = data["longitude"] as! NSNumber
        self.latitude = latitude.doubleValue
        self.longitude = longitude.doubleValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        // super.init(coder:) is optional, see notes below
        self.imageName = aDecoder.decodeObject(forKey: "imageName") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.subTitle = aDecoder.decodeObject(forKey: "subTitle") as! String
        self.desc = aDecoder.decodeObject(forKey: "desc") as! String
        self.latitude = aDecoder.decodeDouble(forKey: "latitude")
        self.longitude = aDecoder.decodeDouble(forKey: "longitude")
    }
    
    func encodeWithCoder(_ aCoder: NSCoder) {
        // super.encodeWithCoder(aCoder) is optional, see notes below
        aCoder.encode(self.imageName, forKey: "imageName")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.subTitle, forKey: "subTitle")
        aCoder.encode(self.desc, forKey: "desc")
        aCoder.encode(self.latitude, forKey: "latitude")
        aCoder.encode(self.longitude, forKey: "longitude")
    }
    
}
