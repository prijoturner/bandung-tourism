//
//  NearMeViewController.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/21/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import Kingfisher
import LKPullToLoadMore
import PKHUD

class NearMeViewController: UIViewController, CLLocationManagerDelegate {
    
    var listDestination: NSMutableArray = []
    var selectedDestination: NSDictionary!
    var staticUrl: String!
    
//    let initialLocation = CLLocation(latitude: -6.8638107, longitude: 107.5921893)
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation! = nil
    
    @IBOutlet weak var nearMeMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        self.listDestination = NSMutableArray.init()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Near Me"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationItem.title = " "
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first! as CLLocation
        self.loadNearMe()
        
        self.centerMapOnLocation(currentLocation)
        
        locationManager.stopUpdatingLocation()
    }

    
    // MARK: - Map View
    func initMap(){
        
    }
    
    let regionRadius: CLLocationDistance = 10000
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        nearMeMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        let annotationIdentifier = "NearMapIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            
            if let destinationAnnotation = annotation as? DestinationAnnotation{
                
                annotationView.canShowCallout = true
                
                let featured = destinationAnnotation.destination?.object(forKey: "featured_image") as! NSDictionary
                let imageURL = featured.value(forKey: "url") as! String!
                
                let urlImage = (URL(string: (self.staticUrl + imageURL!))! as URL)
                let resource:ImageResource! = ImageResource.init(downloadURL: urlImage)
                
                KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                    
                    annotationView.image = self.generatePinImage(image!)
                    
                })//                let imageName = destinationAnnotation.destnation?.imageName
//                annotationView.image = self.generatePinImage(UIImage(named: imageName!)!)
            }
            
        }
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            
            if let destinationAnnotation = annotationView.annotation as? DestinationAnnotation{
                selectedDestination = destinationAnnotation.destination
                self.performSegue(withIdentifier: "segueToDetail", sender: self)
            }
        }
    }

    
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
    
    
    // MARK: - Local
    
    func generatePinImage(_ image:UIImage) -> UIImage{
        let pinImage = UIImage.init(named: "icon-place")
        
        let newSize = pinImage!.size
        
        
        let imageView: UIImageView = UIImageView(image: image)
        
        var frame = imageView.frame
        frame.size = CGSize(width: 44, height: 44)
        
        imageView.frame = frame
        
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(22)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        pinImage!.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        
        
        UIGraphicsGetCurrentContext()?.translateBy(x: 3, y: 3)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
// MARK: - Connection
    func loadNearMe(){
        
        let parameters: Parameters = [
            "latitude": "\(currentLocation.coordinate.latitude)",
            "longitude": "\(currentLocation.coordinate.longitude)"
        ]
        HUD.show(.progress)
        Alamofire.request(kNearURL, parameters:parameters).responseJSON { response in
            HUD.hide()
            let JSON = response.result.value as! NSDictionary
            print("JSON: \(JSON)")
            
            let record = JSON["record"] as! NSArray
            let meta = JSON["meta"] as! NSDictionary
            
            self.staticUrl = meta.value(forKey: "static_url") as! String
            
            
            self.listDestination.addObjects(from: record as! [Any])
            
            for element in self.listDestination{
                let destination = element as! NSDictionary
                
                let latitude = destination.value(forKey: "latitude") as! NSNumber
                let longitude = destination.value(forKey: "longitude") as! NSNumber
                
                let location = CLLocationCoordinate2DMake(CLLocationDegrees(latitude.floatValue) , CLLocationDegrees(longitude.floatValue))
                
                let annotation = DestinationAnnotation.init(coordinate: location, title: destination.value(forKey: "title") as! String, subtitle: "", destination: destination)
                
                self.nearMeMapView.addAnnotation(annotation)
            }
            
        }
    }

}
