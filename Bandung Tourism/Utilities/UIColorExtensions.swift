//
//  UIColorExtensions.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/20/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit
extension UIColor {
    
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
