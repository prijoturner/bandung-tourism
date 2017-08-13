//
//  Data.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/21/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit

let kListDestination:String = "LIST_DESTINATION"

class Data: NSObject {
    
    
    static func setObjectData(_ data:AnyObject, key:String){
        let userDef = UserDefaults.standard
        userDef.set(NSKeyedArchiver.archivedData(withRootObject: data), forKey: key)
        userDef.synchronize()
    }
    
    static func getObjectData(_ key: String) -> AnyObject {
        let userDef: UserDefaults = UserDefaults.standard
        let data: Foundation.Data = userDef.data(forKey: key)!
        return NSKeyedUnarchiver.unarchiveObject(with: data)! as AnyObject
    }

}
