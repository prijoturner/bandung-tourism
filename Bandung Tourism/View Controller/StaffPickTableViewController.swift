//
//  StaffPickTableViewController.swift
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

class StaffPickTableViewController: UITableViewController,LKPullToLoadMoreDelegate {
    
    var listDestination: NSMutableArray = []
    var selectedDestination: NSDictionary!
    var staticUrl: String!
    var offset: NSInteger!
    var loadMoreControl: LKPullToLoadMore!
    var stillHaveData: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offset = 0
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        
        self.listDestination = NSMutableArray.init()
        stillHaveData = false;
        self.loadDataDestination()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        loadMoreControl = LKPullToLoadMore(imageHeight: 30, viewWidth: tableView.frame.width, tableView: tableView)
        loadMoreControl.setIndicatorImage(UIImage(named: "load-icon")!)
        loadMoreControl.enable(true)
        loadMoreControl.delegate = self
        loadMoreControl.resetPosition()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(DestinationTableViewController.reloadData), for: UIControlEvents.valueChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Staff Pick"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationItem.title = " "
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDestination.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let destination = listDestination[(indexPath as NSIndexPath).row] as! NSDictionary
        
        
        let featuredImage = destination.object(forKey: "featured_image") as! NSDictionary
        
        var cell: DestinationTableViewCell
        
        let type = featuredImage.value(forKey: "type") as! String
        
        if(type == "square"){
            
            cell = tableView.dequeueReusableCell(withIdentifier: "destinationSquareCell", for: indexPath) as! DestinationTableViewCell
        }else{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "destinationWideCell", for: indexPath) as! DestinationTableViewCell
        }
        
        let imageURL = featuredImage.value(forKey: "url") as! String
        
        
        let url = URL(string: (self.staticUrl + imageURL))
//        let processor = ResizeImageProcessor(targetWidth:UIScreen.main.bounds.size.width)
        cell.destinationImageView.kf.setImage(with:url)//,options: [.processor(processor)])
//        cell.destinationImageView.kf.setImage(with:url,completionHandler: { image, error, cacheType, imageURL in
//            //                                                        let newImage = self.resizeImage(image: image!, newWidth: UIScreen.main.bounds.size.width)
//            cell.setFeaturedImage(image: image!)
//            cell.layoutIfNeeded()
//        })
        cell.destinationTitleLabel.text = destination.value(forKey: "title") as?String
        
        cell.destinationStaffPickButton.isHidden = false
        
        let categories = destination.object(forKey: "categories") as! NSArray
        
        let catStr = NSMutableString.init()
        
        for category  in categories{
            let catDict = category as! NSDictionary
            catStr.append(catDict.value(forKey: "name") as! String)
            catStr.append("/")
        }
        
        cell.destinationSubtitleLabel.text = catStr.substring(to: catStr.length-1)
        
        // Configure the cell...
        
        return cell

    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        selectedDestination = listDestination[(indexPath as NSIndexPath).row] as! NSDictionary
        self.performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueToDetail" {
            let destinationVC = segue.destination as! DestinationViewController
            destinationVC.destination = selectedDestination
        }
    }
    
    
    func reloadData(){
        self.listDestination = NSMutableArray.init()
        offset = 0
        self.loadDataDestination()
    }
    
    func loadDataDestination(){
        
        let parameters: Parameters = [
            "limit": "10",
            "offset": NSNumber.init(value:offset),
            "staff":"1",
            "search":""
        ]
        HUD.show(.progress)
        Alamofire.request(kExperienceURL, parameters:parameters).responseJSON { response in
            HUD.hide()
            self.refreshControl?.endRefreshing()
            let JSON = response.result.value as! NSDictionary
            print("JSON: \(JSON)")
            
            let meta = JSON["meta"] as! NSDictionary
            
            self.staticUrl = meta.value(forKey: "static_url") as! String
            
            let record = JSON["record"] as! NSArray
            
            if(record.count == 10){
                self.stillHaveData = true
            }else{
                self.stillHaveData = false
            }
            
            self.listDestination.addObjects(from: record as! [Any])
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
            self.tableView.layoutIfNeeded()
            self.tableView.reloadData()
        }
    }
    //MARK: - Load More Control
    func loadMore() {
        if(self.stillHaveData == true){
            offset = offset + 10;
            self.loadDataDestination()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //MARK: - Scroll View
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreControl.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        loadMoreControl.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    
}
