//
//  DestinationTableViewCell.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/21/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit

class DestinationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var destinationHeightImage: NSLayoutConstraint!
    @IBOutlet weak var destinationTitleLabel: UILabel!
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var destinationSubtitleLabel: UILabel!
    @IBOutlet weak var destinationStaffPickButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layoutIfNeeded()
    }
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                destinationImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                destinationImageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func setFeaturedImage(image : UIImage) {
        
        let aspect = image.size.width / image.size.height
        
        aspectConstraint = NSLayoutConstraint.init(item: destinationImageView, attribute: .width, relatedBy: .equal, toItem: destinationImageView, attribute: .height, multiplier: aspect, constant: 0.0)
        
        destinationImageView.image = image
    }


}
