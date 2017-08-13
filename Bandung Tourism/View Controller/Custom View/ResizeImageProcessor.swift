//
//  ResizeProcessor.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 12/9/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import Foundation
import Kingfisher

class ResizeImageProcessor: ImageProcessor {
    public let identifier: String
    
    /// Target size of output image should be.
    public let targetWidth: CGFloat
    
    /// Initialize a `ResizingImageProcessor`
    ///
    /// - parameter targetSize: Target size of output image should be.
    ///
    /// - returns: An initialized `ResizingImageProcessor`.
    public init(targetWidth: CGFloat) {
        self.targetWidth = targetWidth
        self.identifier = "com.onevcat.Kingfisher.ResizexsImageProcessor(\(targetWidth))"
    }
    
    public func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            return resizeImage(image: image, newWidth: self.targetWidth)
        case .data(_):
            return (DefaultImageProcessor.default >> self).process(item: item, options: options)
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in:(CGRect(x:0, y:0, width:newWidth, height:newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
