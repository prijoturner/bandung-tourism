//
//  DestinationViewController.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/21/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import LKPullToLoadMore
import PKHUD
import DTPhotoViewerController
import iCarousel
import XCDYouTubeKit

class DestinationViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    @IBOutlet weak var staffPickButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var destinationImageView: UIImageView!
//    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pagingImage: UIPageControl!
    @IBOutlet weak var carousel: iCarousel!
    
    var destination: NSDictionary!
    var images: NSArray!
    var staticUrl: String!
    var featuredImageURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        carousel.type = .linear
        carousel.isPagingEnabled = true
        
        self.title = "Destination"
        self.loadDestination()
//        destinationImageView.image = UIImage.init(named: self.destination.imageName)
//        titleLabel.text = self.destination.title
//        categoryLabel.text = self.destination.subTitle
//        descriptionLabel.text = self.destination.desc
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Connection
    func loadDestination(){
        
        let tempNumber = self.destination.value(forKey: "id") as! Int
        let idString = String(tempNumber)
        
        let url = kExperienceURL + "/" + idString
        
        HUD.show(.progress)
        Alamofire.request(url).responseJSON { response in
            HUD.hide()
            
            let JSON = response.result.value as! NSDictionary
            print("JSON: \(JSON)")
            
            let meta = JSON["meta"] as! NSDictionary
            self.staticUrl = meta.value(forKey: "static_url") as! String
            let record = JSON["record"] as! NSDictionary
            
            self.titleLabel.text = record.value(forKey: "title") as? String
            
            
            let categories = record.object(forKey: "categories") as! NSArray
            
            let catStr = NSMutableString.init()
            
            for category  in categories{
                let catDict = category as! NSDictionary
                catStr.append(catDict.value(forKey: "name") as! String)
                catStr.append("/")
            }
            
            self.categoryLabel.text = catStr.substring(to: catStr.length-1)
            
            
            
            
            let featuredImage = record.object(forKey: "featured_image") as! NSDictionary
            let imageURL = featuredImage.value(forKey: "url") as! String
            
            
            self.featuredImageURL = URL(string: (self.staticUrl + imageURL))
            
            
            
            let staffPick = record.value(forKey: "staff_pick") as! NSString
            
            self.staffPickButton.isHidden = !staffPick.boolValue
            
            
            
            var description = record.value(forKey: "description") as? String
            //            description = "<div style=\"color:white\">" + description! + "</div>"
            description = description?.replacingOccurrences(of: "</p><p>", with: "\n")
            description = description?.replacingOccurrences(of: "<p>", with: "")
            description = description?.replacingOccurrences(of: "</p>", with: "")
            
            let str = description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            
            let descMutable = NSMutableString.init()
            
            descMutable.append("Address:\n")
            descMutable.append(record.value(forKey: "address") as! String)
            descMutable.append("\n\nDescription:\n")
            descMutable.append(str!)
            
            descMutable.append("\n\nVisiting Hour: ")
            descMutable.append(record.value(forKey: "visiting_hour") as! String)
            descMutable.append("\n\nWebsite: ")
            descMutable.append(record.value(forKey: "website") as! String)
            
            
            self.descriptionLabel.text = descMutable.substring(from: 0)
            
            self.images = record.object(forKey: "gallery") as! NSArray!
            self.carousel.reloadData()
            self.pagingImage.numberOfPages = self.images.count + 1
            self.pagingImage.currentPage = 0;
            //            self.tableView.setNeedsLayout()
            //            self.tableView.layoutIfNeeded()
            //            self.tableView.reloadData()
        }
    }
    
    
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    
    // MARK: - Carousel
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.images != nil ? self.images.count + 1 : 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let url:URL
        var addPlay:Bool = false
        if(index == 0){
            url = self.featuredImageURL
        }else{
            let image = self.images[index-1] as! NSDictionary
            let imageURL = image.value(forKey: "url") as! String
            url = URL(string: (self.staticUrl + imageURL))!
            
            let type = image.value(forKey: "type") as! String
            
            addPlay = type == "youtube"
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: carousel.frame.size.width, height: carousel.frame.size.height))
        imageView.contentMode = .scaleAspectFit
        
        
        imageView.kf.setImage(with:url)
        
        if(addPlay){
            let imagePlay = UIImageView(frame: CGRect(x: (carousel.frame.size.width-50)/2, y: (carousel.frame.size.height-50)/2, width: 50, height: 50))
            imagePlay.image = UIImage.init(named: "play-button")
            imagePlay.alpha = 0.8
            imageView.addSubview(imagePlay)
        }
        
        return imageView
        
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        self.pagingImage.currentPage = carousel.currentItemIndex
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if(index == 0){
            
            let imageView = self.carousel.itemView(at: index) as! UIImageView
            
            if let viewController = DTPhotoViewerController(referenceView: self.carousel, image: imageView.image) {
                self.present(viewController, animated: true, completion: nil)
            }
        }else{
            
            let image = self.images[index-1] as! NSDictionary
        
            let type = image.value(forKey: "type") as! String
            
            if(type == "youtube"){
//                UIApplication.shared.openURL(URL(string: "https://www.youtube.com/watch?v=" + (image.value(forKey: "code") as! String ))!)
                
                let youtubePlayer = XCDYouTubeVideoPlayerViewController.init(videoIdentifier: (image.value(forKey: "code") as! String ))
                self.present(youtubePlayer, animated: true, completion: nil)
//                XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
//                [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];

                
            }else{
                
                let imageView = self.carousel.itemView(at: index) as! UIImageView
                
                if let viewController = DTPhotoViewerController(referenceView: self.carousel, image: imageView.image) {
                    self.present(viewController, animated: true, completion: nil)
                }
                
            }
        }
        

    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.images != nil ? self.images.count : 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) 
//        
//        let image = self.images[(indexPath as NSIndexPath).row] as! NSDictionary
//        
//        let imageView = cell.viewWithTag(1) as! UIImageView
//        
//        let imageURL = image.value(forKey: "url") as! String
//        let url = URL(string: (self.staticUrl + imageURL))
//        
//        imageView.kf.setImage(with:url)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
    
    
    
}
