//
//  BTNavigationViewController.swift
//  Bandung Tourism
//
//  Created by Ebizu-Taufik on 9/20/16.
//  Copyright © 2016 Ezio. All rights reserved.
//

import UIKit

class BTNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes=[NSFontAttributeName: UIFont(name: "GEInspira-Bold", size: 18)!,
                                                                      NSForegroundColorAttributeName:UIColor.white]

        self.navigationBar.tintColor = UIColor.white
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

}
